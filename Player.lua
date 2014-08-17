local Creature = require "Creature"
local Keys = require "Keys"
local Weapon = require "Weapon"
local Bullet = require "Bullet"

local Player = Creature:extend("Player", {
    speed = 3,
    health = 10,
    color = {red = 255, green = 255, blue = 255},
    invincibility_frames = 48
})

local DiagSpeed = 0.709

function Player:init()
    Creature.init(self)

    local w = Weapon:new{
        parent = self,
        reload_rate = 10,
        bullet_class = Bullet:new{
            speed = 6,
            color = {red = 255, green = 255, blue = 0}
        }
    }

    table.insert(self.weapons, w)
end

function Player:update()
    Creature.update(self)

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
            ymov = -(self.speed * DiagSpeed)
        else
            ymov = -self.speed
        end
    elseif keys["down"] == 1 and keys["up"] == 0 then
        if keys["left"] + keys["right"] == 1 then
            ymov = (self.speed * DiagSpeed)
        else
            ymov = self.speed
        end
    end
    if keys["left"] == 1 and keys["right"] == 0 then
        if keys["up"] + keys["down"] == 1 then
            xmov = -(self.speed * DiagSpeed)
        else
            xmov = -self.speed
        end
    elseif keys["right"] == 1 and keys["left"] == 0 then
        if keys["up"] + keys["down"] == 1 then
            xmov = self.speed * DiagSpeed
        else
            xmov = self.speed
        end
    end

    self:move(xmov, ymov)
end

function Player:mousepressed(x, y, button)
    if button == 'l' then
        for _,weapon in pairs(self.weapons) do
            weapon:fire_at(x, y)
        end
    elseif button == 'r' then

    end
end

return Player