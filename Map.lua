local Class = require "Class"

local Map = Class:new{tile_size = 30}

function Map:init(o)
    if not self._walkable then
        self._walkable = {}
    end
    if not self.drawables then
        self.drawables = {}
    end
    if not self.updateables then
        self.updateables = {}
    end

    self:add(self)

    return o
end

function Map:add(o)
    o.map = self
    if o.update ~= nil then
        self.updateables[o] = true
    end
    if o.draw ~= nil then
        self.drawables[o] = true
    end
end

function Map:remove(o)
    o.map = nil
    self.updateables[o] = nil
    self.drawables[o] = nil
end

function Map:walkable(x, y)
    local tilex = math.floor(x / self.tile_size)
    local tiley = math.floor(y / self.tile_size)
    return self:walkableTile(tilex, tiley)
end

function Map:walkableTile(x, y)
    if self._walkable[x] == nil or self._walkable[x][y] == nil then
        return true
    end
    return self._walkable[o]
end

function Map:setWalkable(x, y, walk)
    if self._walkable[x] == nil then
        self._walkable[x] = {}
    end
    self._walkable[x][y] = walk
end

function Map:draw(camera)
    love.graphics.setColor(200, 200, 200)
    for x,sub in pairs(self._walkable) do
        for y,walkable in pairs(sub) do
            if not walkable then
                love.graphics.rectangle("fill",
                    (x * self.tile_size) - camera.x,
                    (y * self.tile_size) - camera.y,
                    self.tile_size,
                    self.tile_size)
            end
        end
    end
end

return Map