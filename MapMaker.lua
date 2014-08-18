local Class = require "Class"
local Map = require "Map"
local Spawner = require "enemy/Spawner"
local Shooter = require "enemy/Shooter"
local Explosion = require "Explosion"
local HealBarrel = require "HealBarrel"

local MapMaker = Class:extend("MapMaker")

function MapMaker:create()
    local m = Map:new()

    for x = 2,25 do
        for y = 2,15 do
            m:setWalkable(x, y, true)
        end
    end

    m:add(Spawner:new{x=400, y=400})
    m:add(Shooter:new{x=600, y=400})
    m:add(Shooter:new{x=600, y=200})
    m:add(HealBarrel:new{x=600,y=175})

    return m
end

return MapMaker