local Class = require "Class"

local Map = Class:new()

function Map:new(o)
    o = Class.new(self, o)

    if not self.walkable then
        self.walkable = {}
    end
    if not self.natural_light then
        self.natural_light = {}
    end
    if not self.drawables then
        self.drawables = {}
    end
    if not self.updateables then
        self.updateables = {}
    end

    return o
end

function Map:add(o)
    if o.update ~= nil then
        self.updateables[o] = true
    end
    if o.draw ~= nil then
        self.drawables[o] = true
    end
end

function Map:remove(o)
    self.updateables[o] = nil
    self.drawables[o] = nil
end

function Map:walkable(x, y)
    return self.walkable[{x, y}] or 0
end

function Map:light(x, y)
    return self.natural_light[{x, y}] or 0
end

return Map