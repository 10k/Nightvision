local Class = require "Class"

local Creature = Class:new{x = 1, y = 1, radius = 10, health = 3}

function Creature:render(camera)
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill",
        camera.x - self.x,
        camera.y - self.y,
        self.radius / 2,
        100)
end

function Creature:update()
    
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

return Creature