local Class = require "Class"
local Map = require "Map"
local Player = require "Player"

local MapMaker = Class:new()

function MapMaker:create()
    local m = Map:new()
    m:setWalkable(1, 1, false)
    m:setWalkable(4, 5, false)
    m:setWalkable(4, 4, false)

    local player = Player:new{ x=200, y=200 }

    m:add(player)

    return m
end

return MapMaker