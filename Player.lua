local Creature = require "Creature"
local Keys = require "Keys"
local Weapon = require "Weapon"
local Bullet = require "Bullet"
local Grenade = require "Grenade"

local Player = Creature:extend("Player", {
    speed = 3,
    max_health = 10,
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

    w = Weapon:new{
        parent = self,
        reload_rate = 100,
        max_ammo = 10,
        bullet_class = Grenade:new{
            speed = 4
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
        self.weapons[1]:fire_at(x, y)
    elseif button == 'r' then
        self.weapons[2]:fire_at(x, y)
    end
end

function Player:heal(healing)
    Creature.heal(self, healing)
    if self.health > self.max_health then
        self.health = self.max_health
    end
end

return Player