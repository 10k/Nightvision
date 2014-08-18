local Bullet = require "Bullet"
local Explosion = require "Explosion"

local Grenade = Bullet:extend("Grenade", {
    color = {red = 255, green = 0, blue = 0},
    lifespan = 75
})

function Grenade:update()
    Bullet.update(self)

    self.lifespan = self.lifespan - 1
    if self.lifespan < 1 then
        self:explode()
    end
end

function Grenade:collide_with(o)
    if o:is_a("Creature") and o ~= self.shooter then
        self:explode()
    end
end

function Grenade:collide_with_wall()
    self:explode()
end

function Grenade:explode()
    local e = Explosion:new{ x = self.x, y = self.y }
    self.map:add(e)
    self.map:remove(self)
end

return Grenade