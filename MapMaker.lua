local Class = require "Class"
local Map = require "Map"
local Player = require "Player"
local Enemy = require "Enemy"

local MapMaker = Class:extend("MapMaker")

function MapMaker:create()
    local m = Map:new()

    for x = 2,25 do
        for y = 2,15 do
            m:setWalkable(x, y, true)
        end
    end

    m.player = Player:new{ x=200, y=200 }

    m:add(m.player)

    m:add(Enemy:new{x=400, y=400})
    m:add(Enemy:new{x=600, y=400})
    m:add(Enemy:new{x=600, y=200})

    return m
end

return MapMaker