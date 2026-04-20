local process = require("@lune/process")
local serde = require("@lune/serde")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

-- Paths
local rootDir = (_G.PESDE_ROOT :: string) .. "/"
local templatesPath = `{rootDir}templates`
local mainPath = `{templatesPath}/main`
local pesdePath = `{templatesPath}/pesde.template.toml`

-- Constants
local RUNTIMES = { "zune", "lune", "lute" }
local ANSI = {
    reset   = "\27[0m",
    red     = "\27[31m",
    green   = "\27[32m",
    cyan    = "\27[36m",
    underline = "\27[4m",
}

-- State
local state: {
    projectName: string,
    runtime: number,
    pesdeContent: string,
    luaurcContent: string,
} = {
    projectName = "",
    runtime = 1,
    pesdeContent = "",
    luaurcContent = "",
}

-- Validates and refines a pesde package name (scope/name format)
local function validateAndRefineName(input: string): (boolean, string)
    local scope, name = input:match("^([^/]+)/([^/]+)$")
    if not scope or not name then
        return false, input
    end
    return true, `{scope:lower():gsub("[-–—]", "_")}/{name:lower():gsub("[-–—]", "_")}`
end

-- Recursively copies directory contents into dest
local function copyDir(src: string, dest: string)
    for _, item in fs.readDir(src) do
        local srcPath = `{src}/{item}`
        local destPath = `{dest}/{item}`
        if fs.isDir(srcPath) then
            if not fs.isDir(destPath) then fs.writeDir(destPath) end
            copyDir(srcPath, destPath)
        else
            fs.writeFile(destPath, fs.readFile(srcPath))
        end
    end
end

-- Steps
local function promptProjectName()
    local isValid, name = false, ""
    repeat
        isValid, name = validateAndRefineName(stdio.prompt("text", "What is the name of your project?"))
        if not isValid then
            stdio.write(`\27[2K\27[A\27[2K\27[1G`)
            stdio.write(`{ANSI.red}# package name {ANSI.underline}'{name}'{ANSI.reset}{ANSI.red} is not in the format {ANSI.underline}'scope/name'{ANSI.reset}\n`)
        end
    until isValid

    local pesdeContent = fs.readFile(pesdePath)
    state.projectName = name
    state.pesdeContent = pesdeContent:gsub(`name = "name/your_project"`, `name = "{name}"`)
end

local function promptRuntime()
    state.runtime = stdio.prompt("select", "Which Luau runtime do you prefer?", { "Zune", "Lune", "Lute" }) :: number
end

local function buildLuauRc(registeredDir: string)
    registeredDir = registeredDir:gsub("/+$", "")

    local luaurcPath = `{templatesPath}/{RUNTIMES[state.runtime]}/luaurc.json`
    local decoded = serde.decode("json", fs.readFile(luaurcPath))

    if registeredDir == "." then
        decoded.aliases.c = process.cwd
    else
        decoded.aliases.c = process.cwd .. registeredDir .. "/"
    end
    
    state.luaurcContent = serde.encode("json", decoded)
end

local function generateProject(registeredDir: string)
    local absDir = if registeredDir == "." then process.cwd else registeredDir
    local runtimeTemplate = `{templatesPath}/{RUNTIMES[state.runtime]}`

    if registeredDir == "." then
        copyDir(runtimeTemplate, absDir)
        copyDir(mainPath, absDir)
    else
        fs.copy(runtimeTemplate, absDir)
        copyDir(mainPath, absDir)
    end

    fs.writeFile(`{absDir}/pesde.toml`, state.pesdeContent)
    fs.writeFile(`{absDir}/.gitignore`, fs.readFile(`{rootDir}/.gitignore`))
    fs.writeFile(`{absDir}/.luaurc`, state.luaurcContent)
end

local function printSuccess(registeredDir: string)
    local runtime = RUNTIMES[state.runtime]
    
    print(`\n{ANSI.green}Your Nova project is created successfully!{ANSI.reset}\n`)
    print("Try running:\n")

    if registeredDir ~= "." then
        print(`{ANSI.cyan}cd {registeredDir}\n`)
    end

    print(`{ANSI.cyan}pesde install`)
    print(`{runtime} run start{ANSI.reset}\n`)
end

-- Entry point
local arg = process.args[1] or "."
promptProjectName()
promptRuntime()
buildLuauRc(arg)
generateProject(arg)
printSuccess(arg)