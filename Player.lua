local Creature = require "Creature"
local Keys = require "Keys"
local Bullet = require "Bullet"

local Player = Creature:extend("Player", {walk_speed = 3, run_speed = 6})

local DiagSpeed = 0.709

function Player:update()
    Creature.update(self)

    speed = self.walk_speed
    if love.keyboard.isDown(Keys.run) then
        speed = self.run_speed
    end

    keys = {}
    for _,k in pairs({"up", "down", "left", "right"}) do
        if love.keyboard.isDown(Keys[k]) then
            keys[k] = 1
        else
            keys[k] = 0
        end
    end

    xmov = 0
    ymov = 0
    if keys["up"] == 1 and keys["down"] == 0 then
        if keys["left"] + keys["right"] == 1 then
            ymov = -(speed * DiagSpeed)
        else
            ymov = -speed
        end
    elseif keys["down"] == 1 and keys["up"] == 0 then
        if keys["left"] + keys["right"] == 1 then
            ymov = (speed * DiagSpeed)
        else
            ymov = speed
        end
    end
    if keys["left"] == 1 and keys["right"] == 0 then
        if keys["up"] + keys["down"] == 1 then
            xmov = -(speed * DiagSpeed)
        else
            xmov = -speed
        end
    elseif keys["right"] == 1 and keys["left"] == 0 then
        if keys["up"] + keys["down"] == 1 then
            xmov = speed * DiagSpeed
        else
            xmov = speed
        end
    end

    self:move(xmov, ymov)
end

function Player:draw(camera)
    if self.invincibility_frames > 0 then
        love.graphics.setColor(0, 0, 255)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.circle("fill",
        self.x - camera.x,
        self.y - camera.y,
        self.radius,
        100)
end

function Player:mousepressed(x, y, button)
    if button == 'l' then
        local b = Bullet:new{x=self.x, y=self.y, shooter=self}
        b:fire_at(x, y, 5)
        self.map:add(b)
    elseif button == 'r' then

    end
end

return Player