local Class = require "Class"

local Creature = Class:new()

function Creature:init()
end

function Creature:render(camera)
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", camera.x - self.x, camera.y - self.y, 10, 10)
end

function Creature:update()
    
end

return Creature