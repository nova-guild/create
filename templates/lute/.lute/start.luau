local process = require("@lute/process")

local running = process.run({ "lute", "run", "src/main" }, { stdio = "inherit" })

if not running.ok then 
    print(running.stderr)
end