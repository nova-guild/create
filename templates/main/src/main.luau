local Nova = require("@nova")

local app = Nova.new(8080)

app:listen(function()
    print("Nova is running on Port 8080")
end)
