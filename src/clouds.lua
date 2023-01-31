local clouds = {}

-- Nubes--

clouds.img = love.graphics.newImage("assets/images/clouds.png")
clouds.width = clouds.img:getWidth()
clouds.x1 = 0
clouds.x2 = clouds.width
clouds.speed = 120

function clouds.update(dt)

-- Moviento de las nubes--

    clouds.x1 = clouds.x1 - (clouds.speed * dt)
    clouds.x2 = clouds.x2 - (clouds.speed * dt)
    
    if (clouds.x1 + clouds.width < 0) then
        clouds.x1 = clouds.x2 + clouds.width
    end
    if (clouds.x2 + clouds.width < 0) then
        clouds.x2 = clouds.x1 + clouds.width
    end
end

function clouds.draw()

-- Dibujar nubes--

    love.graphics.push()
    love.graphics.scale(0.76, 0.76)
    love.graphics.draw(clouds.img, clouds.x1)
    love.graphics.draw(clouds.img, clouds.x2)
    love.graphics.pop()

end

return clouds