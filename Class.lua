local Class = {}

function Class:new(o)
    local o = o or {}
    o.mt = {__index = self}
    setmetatable(o, o.mt)
    o:init()
    return o
end

function Class:init()
end

return Class