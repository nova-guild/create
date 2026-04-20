local Nova = require("@nova")

local Home = {}

function Home.Get()
    return Nova.response.json({ msg = "Hello, Nova" })
end

return Home
