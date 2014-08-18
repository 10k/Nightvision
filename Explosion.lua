local Class = require "Class"

local Explosion = Class:extend("Explosion", {
    radius = 1,
    damage = 2,
    total_radius = 75,
    expansion_speed = 4,
    color = {red = 255, green = 150, blue = 0}
})

function Explosion:update()
    if self.radius < self.total_radius then
        self.radius = self.radius + self.expansion_speed
    else
        self.map:remove(self)
    end
end

function Explosion:draw(camera)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.circle("line",
            self.x - camera.x,
            self.y - camera.y,
            self.radius,
            100)
end

function Explosion:collide_with(o)
    -- do nothing but let other objects collide with me
end

return Explosion