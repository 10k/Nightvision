local Class = require "Class"

local Bullet = Class:extend("Bullet", {
    x = 0,
    y = 0,
    xspeed = 0,
    yspeed = 0,
    damage = 1,
    radius = 2
})

-- set the velocity so the bullet flies towards the given target
function Bullet:fire_at(x, y, speed)
    local xdiff = x - self.x
    local ydiff = y - self.y
    local len = math.sqrt(xdiff * xdiff + ydiff * ydiff)

    self.xspeed = (xdiff / len) * speed
    self.yspeed = (ydiff / len) * speed
end

function Bullet:update()
    self.x = self.x + self.xspeed
    self.y = self.y + self.yspeed

    if not self.map:walkable(self.x, self.y) then
        self.map:remove(self)
    end
end

function Bullet:draw(camera)
    love.graphics.setColor(255, 0, 255)
    love.graphics.circle("fill",
        self.x - camera.x,
        self.y - camera.y,
        self.radius,
        20)
end

function Bullet:collide_with(o)
    if o:is_a("Creature") and self.shooter ~= o then
        self.map:remove(self)
    end
end

return Bullet