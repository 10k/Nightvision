local Class = require "Class"

local Gui = Class:extend("Gui")

function Gui:draw(camera)
    love.graphics.setColor(255, 0, 0)

    for hp = 1, self.map.player.health do
        love.graphics.rectangle(
            "fill",
            hp * 15,
            10,
            10,
            10
        )
    end
end

return Gui