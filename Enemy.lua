local Creature = require "Creature"
local Bullet = require "Bullet"

local Enemy = Creature:extend("Enemy", {
    reload_frames = 0,
    reload_time = 100
})

function Enemy:update()
    Creature.update(self)

    if self.reload_frames > 0 then
        self.reload_frames = self.reload_frames - 1
    else
        self.reload_frames = self.reload_time
        local b = Bullet:new{x=self.x, y=self.y, shooter=self}
        b:fire_at(self.map.player.x, self.map.player.y, 3)
        self.map:add(b)
    end
end

return Enemy