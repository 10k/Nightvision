local Explosion = require "Explosion"

local HealExplosion = Explosion:extend("HealExplosion", {
    color = {red = 0, green = 255, blue = 0},
    healing = 3,
    total_radius = 100
})

return HealExplosion