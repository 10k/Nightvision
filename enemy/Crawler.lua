local Creature = require "Creature"
local Util = require "Util"

local Crawler = Creature:extend("Crawler", {
    max_health = 2,
    color = {red=255, green=150, blue=0},
    activated = false,
    speed = 2,
    touch_damage = 3,
    team = "Monster"
})

function Crawler:update()
    Creature.update(self)

    if self.activated then
        local x, y = Util:normalized_towards(self.x, self.y, self.map.player.x, self.map.player.y)
        self:move(x * self.speed, y * self.speed)
    else
        if Util:distance(self.x, self.y, self.map.player.x, self.map.player.y) < 100 then
            self.activated = true
        end
    end
end

function Crawler:take_damage(dmg)
    Creature.take_damage(self, dmg)

    self.activated = true
end

return Crawler