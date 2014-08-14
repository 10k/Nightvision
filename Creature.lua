local Class = require "Class"

local Creature = Class:new{x = 1, y = 1, body_size = 20}

function Creature:render(camera)
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill",
        camera.x - self.x,
        camera.y - self.y,
        self.body_size / 2,
        100)
end

function Creature:update()
    
end

function Creature:move(xdiff, ydiff)
    if self.map:walkable(self.x + xdiff, self.y + ydiff) then
        self.x = self.x + xdiff
        self.y = self.y + ydiff
    elseif self.map:walkable(self.x + xdiff, self.y) then
        self.x = self.x + xdiff
    elseif self.map:walkable(self.x, self.y + ydiff) then
        self.y = self.y + ydiff
    end
end

return Creature