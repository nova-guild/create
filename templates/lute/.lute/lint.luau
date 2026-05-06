local process = require("@lute/process")

local result = process.run({ "pesde", "run", "/lune_packages/selene.bin.luau", "--", "src/" }, { stdio = "inherit" })
print("\nLint Check Done...")

if not result.ok then
    process.exit(result.exitcode)
end