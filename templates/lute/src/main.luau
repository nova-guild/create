local Nova = require('@nova')
local process = require('@lute/process')

local PORT = process.env.PORT or 8080
local app = Nova.new(PORT :: number)

app:listen(function()
    print(`Nova is running on Port {PORT}`)
end)
