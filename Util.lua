local Util = {}

function Util:distance(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2), math.pow(y1 - y2, 2))
end

function Util:normalized_towards(x1, y1, x2, y2)
    local xdiff = x2 - x1
    local ydiff = y2 - y1
    local len = math.sqrt(xdiff * xdiff + ydiff * ydiff)

    return xdiff / len, ydiff / len
end

return Util