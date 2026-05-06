local process = zune.process
local fs = zune.fs

local vscodeDir = fs.stat("../.vscode/settings.json")

if not (vscodeDir.kind == "file") then
    process.run("zune", { "setup", "vscode" })
end

process.run("zune", { "run", "src/main" }, { 
    stderr = "inherit",
    stdout = "inherit"
})