local Class = require "Class"
local Map = require "Map"
local Player = require "Player"

local MapMaker = Class:new()

function MapMaker:create()
    local m = Map:new()

    for x = 2,25 do
        for y = 2,15 do
            m:setWalkable(x, y, true)
        end
    end

    m.player = Player:new{ x=200, y=200 }

    m:add(m.player)

    return m
end

return MapMaker