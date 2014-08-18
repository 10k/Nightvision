local Class = require "Class"
local Bullet = require "Bullet"

local Weapon = Class:extend("Weapon", {
    bullet_class = Bullet,
    reload_rate = 100,
    reload_remaining = 0,
    max_ammo = 100,
    parent = {x=0, y=0}
})

function Weapon:init()
    Class.init(self)

    self.ammo = self.max_ammo
end

function Weapon:fire_at(x, y)
    if self.reload_remaining > 0 or self.ammo < 1 then
        return
    end

    self.ammo = self.ammo - 1
    self.reload_remaining = self.reload_rate

    local b = self.bullet_class:new{
        x = self.parent.x,
        y = self.parent.y,
        team = self.parent.team
    }
    b:fire_at(x, y)
    self.parent.map:add(b)
end

function Weapon:update()
    if self.reload_remaining > 0 then
        self.reload_remaining = self.reload_remaining - 1
    end
end

return Weapon