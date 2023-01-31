function newParallaxLayer(imageFilename, speed) 
    local parallaxLayer = {}

-- Pinos y niebla--

    parallaxLayer.image = love.graphics.newImage(imageFilename)
    parallaxLayer.width = parallaxLayer.image:getWidth()
    parallaxLayer.x1 = 0
    parallaxLayer.x2 = parallaxLayer.width
    parallaxLayer.speed = 80

    function parallaxLayer.update(dt)

-- Movimiento de los pinos y niebla--

        parallaxLayer.x1 = parallaxLayer.x1 - (parallaxLayer.speed * dt)
        parallaxLayer.x2 = parallaxLayer.x2 - (parallaxLayer.speed * dt)

        if (parallaxLayer.x1 + parallaxLayer.width < 0) then
            parallaxLayer.x1 = parallaxLayer.x2 + parallaxLayer.width
        end
        if (parallaxLayer.x2 + parallaxLayer.width < 0) then
            parallaxLayer.x2 = parallaxLayer.x1 + parallaxLayer.width
        end
    end

    function parallaxLayer.draw()
        
--Dibujar pinos y niebla--

        love.graphics.push()
        love.graphics.setColor(0.57, 0.43, 0.85)
        love.graphics.scale(2.5, 0.7)
        love.graphics.draw(parallaxLayer.image, parallaxLayer.x1, 400)
        love.graphics.draw(parallaxLayer.image, parallaxLayer.x2, 400)
        love.graphics.pop()
    end
    
    return parallaxLayer
end