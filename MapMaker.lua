local Class = require "Class"
local Map = require "Map"
local Player = require "Player"

local MapMaker = Class:new()

function MapMaker:create()
    local m = Map:new()

    local player = Player:new{x=100, y=100}

    m:add(player)

    return m
end

return MapMaker