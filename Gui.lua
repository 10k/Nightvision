local Class = require "Class"

local Gui = Class:extend("Gui")

function Gui:draw(camera)
    -- grey background
    love.graphics.setColor(200, 200, 200)
    love.graphics.rectangle("fill",
        10,
        6,
        self.map.player.max_health * 14 + 4,
        18)

    love.graphics.rectangle("fill",
        196,
        6,
        80,
        19)

    -- health bar
    for hp = 1, self.map.player.max_health do
        if hp > self.map.player.health then
            love.graphics.setColor(0, 0, 0)
        else
            love.graphics.setColor(255, 0, 0)
        end
        love.graphics.rectangle(
            "fill",
            hp * 14,
            10,
            10,
            10
        )
    end

    -- ammo
    love.graphics.setColor(0, 0, 0)
    for x,weapon in pairs(self.map.player.weapons) do
        local count = weapon.ammo
        love.graphics.print(
            count,
            150 + (x * 50),
            10
        )
    end
end

return Gui