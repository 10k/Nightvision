local Class = require "Class"

local Barrel = Class:extend("Barrel", {
    health = 2,
    x = 0,
    y = 0,
    radius = 10,
    color = {red = 200, green = 200, blue = 200}
})

function Barrel:draw(camera)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.rectangle("line",
        self.x - self.radius - camera.x,
        self.y - self.radius - camera.y,
        self.radius * 2,
        self.radius * 2)
end

function Barrel:collide_with(o)
    if o:is_a("Bullet") then
        self:take_damage(o.damage)
    elseif o == self.map.player then
        self:explode()
    end
end

function Barrel:take_damage(dmg)
    self.health = self.health - dmg
    if self.health < 1 then
        self:explode()
    end
end

function Barrel:explode()
    -- override in children
end

return Barrel