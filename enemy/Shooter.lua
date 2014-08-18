local Creature = require "Creature"
local Weapon = require "Weapon"

local Shooter = Creature:extend("Shooter", {
    reload_frames = 0,
    reload_time = 100,
    team = "Monster"
})

function Shooter:init()
    Creature.init(self)

    local w = Weapon:new{ parent = self }
    self.weapons = {}
    table.insert(self.weapons, w)
end

function Shooter:update()
    Creature.update(self)

    for _,weapon in pairs(self.weapons) do
        weapon:fire_at(self.map.player.x, self.map.player.y)
    end
end

return Shooter