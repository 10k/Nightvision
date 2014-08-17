local Class = require "Class"

local Camera = Class:extend("Camera", {
    x=30,
    y=30,
    move_range=50,
    max_speed=3,
    accel=0.1,
    xspeed=0,
    yspeed=0
})

function Camera:update()
    local centerx = self.x + love.graphics.getWidth() / 2
    local centery = self.y + love.graphics.getHeight() / 2

    local xdist = math.abs(centerx - self.map.player.x)
    local ydist = math.abs(centery - self.map.player.y)

    if xdist > self.move_range then
        -- accel
        if self.map.player.x > centerx then
            self.xspeed = math.min(self.max_speed, self.xspeed + self.accel)
        else
            self.xspeed = math.max(-self.max_speed, self.xspeed - self.accel)
        end
    else
        -- decel
        if self.xspeed > 0 then
            self.xspeed = math.max(0, self.xspeed - self.accel)
        else
            self.xspeed = math.min(0, self.xspeed + self.accel)
        end
    end

    if ydist > self.move_range then
        -- accel
        if self.map.player.y > centery then
            self.yspeed = math.min(self.max_speed, self.yspeed + self.accel)
        else
            self.yspeed = math.max(-self.max_speed, self.yspeed - self.accel)
        end
    else
        -- decel
        if self.yspeed > 0 then
            self.yspeed = math.max(0, self.yspeed - self.accel)
        else
            self.yspeed = math.min(0, self.yspeed + self.accel)
        end
    end

    self.x = self.x + self.xspeed
    self.y = self.y + self.yspeed
end

return Camera