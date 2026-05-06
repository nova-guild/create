local process = zune.process

local args = process.args
local index = table.find(args, "--check")

local result

if not index then
    result = process.run("pesde", { "run", "/lune_packages/stylua.bin.luau", "--", "src/" }, { 
        stderr = "inherit",
        stdout = "inherit"
    })
    print("Format Done...")
else
    result = process.run("pesde", { "run", "/lune_packages/stylua.bin.luau", "--", args[index], "src/" }, { 
        stderr = "inherit",
        stdout = "inherit"
    })
    print("\nFormat Check Done...")
end

if not result.ok then
    process.exit(result.code)
end