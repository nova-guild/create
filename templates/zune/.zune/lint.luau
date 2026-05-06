local process = zune.process

local result = process.run("pesde", { "run", "/lune_packages/selene.bin.luau", "--", "src/" }, { 
    stderr = "inherit",
    stdout = "inherit"
})
print("\nLint Check Done...")

if not result.ok then
    process.exit(result.code)
end