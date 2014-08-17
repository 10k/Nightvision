local MapMaker = require "MapMaker"
local Camera = require "Camera"
local Gui = require "Gui"
local Player = require "Player"

local paused = false
local map = nil

function love.load()
    map = MapMaker:new():create()

    map.player = Player:new{ x=200, y=200 }
    map:add(map.player)

    map.camera = Camera:new()
    map:add(map.camera)

    map:add(Gui:new())

    love.graphics.setBackgroundColor(200, 200, 200)
end

function love.update()
    if paused then
        return
    end

    map:update()
end

function love.draw()
    map:draw(map.camera)
end

function love.mousepressed(x, y, button)
    map.player:mousepressed(x + map.camera.x, y + map.camera.y, button)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.quit()

end

function love.focus(f)
    paused = not f
end