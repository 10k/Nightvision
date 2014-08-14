local MapMaker = require "MapMaker"
local Camera = require "Camera"

local paused = false
local map = nil
local camera = nil

function love.load()
    map = MapMaker:new():create()
    camera = Camera:new()
    map:add(camera)

    love.graphics.setBackgroundColor(200, 200, 200)
end

function love.update()
    if paused then
        return
    end

    map:update()
end

function love.draw()
    map:draw(camera)
end

function love.mousepressed(x, y, button)
    map.player:mousepressed(x + camera.x, y + camera.y, button)
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