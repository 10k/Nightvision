local Class = require "Class"

local Map = Class:extend("Map", {tile_size = 30})

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
    if not self.collidables then
        self.collidables = {}
    end

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
    if o.collide_with ~= nil then
        table.insert(self.collidables, o)
    end
end

function Map:remove(o)
    o.map = nil
    self.updateables[o] = nil
    self.drawables[o] = nil
    if o.collide_with ~= nil then
        for i = 1,table.getn(self.collidables) do
            if self.collidables[i] == o then
                table.remove(self.collidables, i)
            end
        end
    end
end

function Map:walkable(x, y)
    local tilex = math.floor(x / self.tile_size)
    local tiley = math.floor(y / self.tile_size)
    return self:walkableTile(tilex, tiley)
end

function Map:walkableTile(x, y)
    if self._walkable[x] == nil or self._walkable[x][y] == nil then
        return false
    end
    return self._walkable[x][y]
end

function Map:setWalkable(x, y, walk)
    if self._walkable[x] == nil then
        self._walkable[x] = {}
    end
    self._walkable[x][y] = walk
end

function Map:update()
    for k,_ in pairs(self.updateables) do
        k:update()
    end

    -- clone in case something is removed
    local cc = {}
    for k,v in pairs(self.collidables) do
        cc[k] = v
    end

    for i = 1,table.getn(cc) do
        for j = i+1, table.getn(cc) do
            local a = cc[i]
            local b = cc[j]

            local dist = math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2))
            if dist < a.radius + b.radius then
                a:collide_with(b)
                b:collide_with(a)
            end
        end
    end
end

function Map:draw(camera)
    love.graphics.setColor(0, 0, 0)

    local min_x = math.floor(camera.x / self.tile_size)
    local min_y = math.floor(camera.y / self.tile_size)
    local max_x = min_x + math.ceil(love.graphics.getWidth() / self.tile_size)
    local max_y = min_y + math.ceil(love.graphics.getHeight() / self.tile_size)

    for x = min_x, max_x do
        for y = min_y, max_y do
            if self:walkableTile(x, y) then
                love.graphics.rectangle("fill",
                    (x * self.tile_size) - camera.x,
                    (y * self.tile_size) - camera.y,
                    self.tile_size,
                    self.tile_size)
            end
        end
    end

    for k,_ in pairs(self.drawables) do
        k:draw(camera)
    end
end

return Map