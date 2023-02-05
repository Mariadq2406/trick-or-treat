-- Pantalla completa --

love.window.setFullscreen(true)

function love.load()
    W, H = love.graphics.getDimensions()

-- Estado 0 menú; estado 1 juego; estado 2 pantalla de Game Over --

	state = 0

-- Puntos--

    score = 0
    highscore = 0

-- Se crea un archivo .txt para guardar los puntos --

    if not love.filesystem.getInfo("highscore.txt") then
        love.filesystem.write("highscore.txt", "0\n")
    end
    for line in love.filesystem.lines("highscore.txt") do
        highscore = tonumber(line)
    end

-- Requerimientos --

    GUI = require("gui")
	player = require("player")
    clouds = require ("clouds")
	require("enemy")
    require("parallax")
   
-- Música de fondo --

	soundtrack = love.audio.newSource("assets/audio/soundtrack.mp3", "static")
	soundtrack:setLooping(true)
	love.audio.play(soundtrack)
    gameover = love.audio.newSource("assets/audio/gameover.mp3", "static")
    gameover:setLooping(true)
  
-- Fondo --

    moon = love.graphics.newImage("assets/images/moon.png")
    sky = love.graphics.newImage("assets/images/sky.png")
    layers = {}
    local path = "assets/images/background/"
    table.insert(layers, newParallaxLayer(path .. "1.png", 65))
    table.insert(layers, newParallaxLayer(path .. "2.png", 65))
   
-- Fuentes --
    fonts = {}
    fonts.xxl = love.graphics.newFont("assets/fonts/Alkhemikal.ttf", 140)
    fonts.xl = love.graphics.newFont("assets/fonts/Alkhemikal.ttf", 96)
    fonts.md = love.graphics.newFont("assets/fonts/Alkhemikal.ttf", 40)
    fonts.mmd = love.graphics.newFont("assets/fonts/Alkhemikal.ttf", 36)
    
-- Vida--

    GUI:load()
end

function love.keypressed(key)

-- Al hacer click en escape se sale del juego --

	if key == "escape" then
		love.event.quit()
	end
    
-- Empezar al juego --

    if key == "return" then
        if state == 0 then
            state = 1
            score = 0
            health = {current = 3, max = 3}
            enemyMinSpeed = 150
            enemyMaxSpeed = 200
            tBtwnSpeedIncreases = 10
            tSinceLastSpeedIncrease = 0

-- Crear enemigos --

    enemies = {}
    local enemy = newEnemy(W + love.math.random(50, 100))
    table.insert(enemies, enemy)
    for i = 2, 6 do
        enemy = newEnemy(enemies[i - 1].x + love.math.random(200, 400))
        table.insert(enemies, enemy)
    end

-- Resetear posición del jugador--

     player.x = W * 0.05 
     player.y = (H * 0.5) - (player.h * 0.5)
    elseif state == 2 then
        state = 0 
    end
end
end

function love.update(dt)

-- Update de las nubes y objetos--

    clouds.update(dt)
    for i = 1, #layers do
        layers[i].update(dt)
    end

    if state == 0 then
        soundtrack:play()
        gameover:stop()
 
    elseif state == 1 then   
        soundtrack:play()
        gameover:stop()

-- El enemigo se hace más rápido --

        tSinceLastSpeedIncrease = tSinceLastSpeedIncrease + dt
        if (tSinceLastSpeedIncrease >= tBtwnSpeedIncreases) then
            enemyMinSpeed = enemyMinSpeed + 20
            enemyMaxSpeed = enemyMaxSpeed + 20
            tSinceLastSpeedIncrease = 0
        end
        
-- Update del Jugador y enemigos --

        player.update(dt)
        for i = 1, #enemies do
            enemies[i].update(dt)
        end

        score = score + dt
        if score > highscore then
            highscore = math.floor(score + 0.8)
        end
        
-- La música se detiene cuando el jugador pierde --

    elseif state == 2 then
       gameover:play()
        soundtrack:stop()
    end

end

function love.draw()

-- Dibujar fondo --

    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sky, 0,0)
    love.graphics.draw(moon, 700, 100, 0, 3, 3)
    clouds.draw(clouds)
    layers[1].draw()
    layers[2].draw()
    love.graphics.pop()

-- Dibujar al jugador, enemigos y HP --

	if state == 1 then
        player.draw() 
        for i = 1, #enemies do
            enemies[i].draw()
        end
        GUI:draw(dt)
    end

-- Dibujar mensajes en pantalla --

    love.graphics.setColor(1, 0.56, 0)
    if state == 0 then
        love.graphics.setFont(fonts.xxl)
        love.graphics.printf("TRICK OR TREAT", 0, H * 0.25, W, "center")

        love.graphics.setFont(fonts.md)
        love.graphics.printf("HAZ CLICK EN ENTER PARA EMPEZAR A JUGAR", 0, H * 0.50, W, "center")

        love.graphics.printf("USA LAS FLECHAS PARA MOVERTE", 0, H * 0.60, W, "center")        
        love.graphics.printf("¡NO DEJES QUE LOS ENEMIGOS TE TOQUEN!", 0, H * 0.66, W, "center")  
        
        love.graphics.printf("(ESC) PARA SALIR", 0, H * 0.76, W, "center")
    elseif state == 1 then
        love.graphics.setFont(fonts.mmd)
        love.graphics.print("PUNTOS: " .. math.floor(score + 0.8), 10, 10)
        love.graphics.print("PUNTAJE MÁS ALTO: " .. highscore, 10, 55)
    elseif state == 2 then
        love.graphics.setFont(fonts.xl)
        love.graphics.printf("¡FIN DEL JUEGO!", 0, H * 0.25, W, "center")

        love.graphics.setFont(fonts.md)
        love.graphics.printf(":(", 0, H * 0.40, W, "center")
        love.graphics.printf("PUNTOS: " .. math.floor(score + 0.8), 0, H * 0.50, W, "center")
        love.graphics.printf("PUNTAJE MÁS ALTO: " .. highscore, 0, H * 0.56, W, "center")
        love.graphics.printf("HAZ CLICK EN ENTER PARA VOLVER Al MENÚ", 0, H * 0.70, W, "center")
        love.graphics.printf("(ESC) PARA SALIR", 0, H * 0.76, W, "center") 
    end
end