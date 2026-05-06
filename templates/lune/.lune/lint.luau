local process = require("@lune/process")

local result = process.exec("pesde", { "run", "/lune_packages/selene.bin.luau", "--", "src/" }, { stdio = "inherit" })
print("\nLint Check Done...")

if not result.ok then
    process.exit(result.code)
end