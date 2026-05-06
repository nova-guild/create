local process = require("@lune/process")

local args = process.args
local index = table.find(args, "--check")

local result

if not index then
    result = process.exec("pesde", { "run", "/lune_packages/stylua.bin.luau", "--", "src/" }, { stdio = "inherit" })
    print("Format Done...")
else
    result = process.exec("pesde", { "run", "/lune_packages/stylua.bin.luau", "--", args[index], "src/" }, { stdio = "inherit" })
    print("\nFormat Check Done...")
end

if not result.ok then
    process.exit(result.code)
end