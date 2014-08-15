local Class = {class_names = {Class = true} }

function Class:new(o)
    o = o or {}
    o.mt = {__index = self}
    setmetatable(o, o.mt)
    o:init()
    return o
end

function Class:extend(classname, o)
    o = self:new(o)
    -- clone class names
    o.class_names = {}
    for k,_ in pairs(self.class_names) do
        o.class_names[k] = true
    end
    o.class_names[classname] = true
    
    return o
end

function Class:init()
end

function Class:is_a(o)
    return self.class_names[o] ~= nil
end

return Class