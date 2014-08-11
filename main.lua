MapMaker = require "MapMaker"

paused = false
map = nil

function love.load()
    map = MapMaker:new():create()
end

function love.update()
    if paused then
        return
    end

    for k,_ in pairs(map.updateables) do
        k:update()
    end
end

function love.draw()
    for k,_ in pairs(map.drawables) do
        k:draw({x = 0, y = 0})
    end
end

function love.mousepressed(x, y, button)
    -- throw a coin
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