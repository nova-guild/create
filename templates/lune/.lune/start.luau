local process = require("@lune/process")

local running = process.exec("lune", { "run", "src/main" }, { stdio = "inherit" })

if not running.ok then 
    print(running.stderr)
end