local Nova = require("@nova")

local Home = {}

function Home.Get(req: Nova.RequestWith<{ id: string }>)
    local userId = req.params.id
    return Nova.response.json({ userId = userId, msg = "Found a user ID" })
end

return Home
