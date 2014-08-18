local Creature = require "Creature"
local Crawler = require "enemy/Crawler"

local Spawner = Creature:extend("Spawner", {
    spawn_rate = 100,
    spawn_time = 50,
    radius = 15,
    color = {red = 200, green = 0, blue = 0},
    team = "Monster"
})

function Spawner:update()
    Creature.update(self)
    
    self.spawn_time = self.spawn_time - 1

    if self.spawn_time < 1 then
        self.spawn_time = self.spawn_rate

        local c = Crawler:new{ x = self.x + math.random(-25, 25), y = self.y + math.random(-25, 25) }
        self.map:add(c)
    end
end

return Spawner