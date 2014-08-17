local Creature = require "Creature"
local Weapon = require "Weapon"

local Enemy = Creature:extend("Enemy", {
    reload_frames = 0,
    reload_time = 100
})

function Enemy:init()
    Creature.init(self)

    local w = Weapon:new{ parent = self }
    self.weapons = {}
    table.insert(self.weapons, w)
end

function Enemy:update()
    Creature.update(self)

    for _,weapon in pairs(self.weapons) do
        weapon:fire_at(self.map.player.x, self.map.player.y)
    end
end

return Enemy