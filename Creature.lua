local Class = require "Class"

local Creature = Class:extend("Creature", {
    x = 1,
    y = 1,
    radius = 10,
    max_health = 3,
    invincibility_frames = 24,
    invincibility_remaining = 0,
    color = {red = 255, green = 0, blue = 0}
})

function Creature:init()
    self.health = self.max_health
    
    self.weapons = {}
    self.effects = {}
end

function Creature:effect(name)
    return self.effects[name] or 0
end

function Creature:draw(camera)
    if self:effect("invincibility") % 6 > 3 then
        return
    elseif self:effect("healing") % 6 > 2 then
        love.graphics.setColor(0, 255, 0)
    else
        love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    end

    love.graphics.circle("fill",
        self.x - camera.x,
        self.y - camera.y,
        self.radius,
        100)
end

function Creature:update()
    for effect,z in pairs(self.effects) do
        if z > 0 then
            self.effects[effect] = z - 1
        end
    end

    for _,weapon in pairs(self.weapons) do
        weapon:update()
    end
end

function Creature:move(xdiff, ydiff)
    local myx = self.x
    if xdiff < 0 then myx = myx - self.radius else myx = myx + self.radius end
    local myy = self.y
    if ydiff < 0 then myy = myy - self.radius else myy = myy + self.radius end

    if self.map:walkable(myx + xdiff, myy + ydiff) then
        self.x = self.x + xdiff
        self.y = self.y + ydiff
    elseif self.map:walkable(myx + xdiff, myy) then
        self.x = self.x + xdiff
    elseif self.map:walkable(myx, myy + ydiff) then
        self.y = self.y + ydiff
    end
end

function Creature:collide_with(o)
    if o:is_a("Bullet") and o.shooter ~= self then
        self:take_damage(o.damage)
    elseif o:is_a("HealExplosion") then
        self:heal(o.healing)
    elseif o:is_a("Explosion") then
        self:take_damage(o.damage)
    end
end

function Creature:heal(healing)
    if self:effect("healing") < 1 then
        self.health = self.health + healing
        self.effects.healing = 24
    end
end

function Creature:take_damage(dmg)
    if self:effect("invincibility") > 0 then
        return
    end
    self.health = self.health - dmg
    self.effects.invincibility = self.invincibility_frames
    if self.health < 1 then
        self:die()
    end
end

function Creature:die()
    self.dead = true
    self.map:remove(self)
end

return Creature