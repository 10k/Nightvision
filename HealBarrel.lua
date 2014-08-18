local Barrel = require "Barrel"
local HealExplosion = require "HealExplosion"

local HealBarrel = Barrel:extend("HealBarrel", {
    health = 2,
    color = {red = 0, green = 255, blue = 0}
})

function HealBarrel:explode()
    self.map:add(HealExplosion:new{
        x = self.x,
        y = self.y
    })
    self.map:remove(self)
end

return HealBarrel