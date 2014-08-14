local Creature = require "Creature"
local Keys = require "Keys"

local Player = Creature:new{walk_speed = 1, run_speed = 2}

local DiagSpeed = 0.709

function Player:update()
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
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill",
        self.x - camera.x,
        self.y - camera.y,
        self.body_size / 2,
        100)
end

return Player