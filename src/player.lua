local player = {}

-- Animación del jugador--

player.animationFrames = {}
for i = 1, 4 do
    local frame = love.graphics.newImage("assets/images/player/" .. i .. ".png")
    table.insert(player.animationFrames, frame)
end
local currentFrame = 1
local tBtwnFrames = 0.1
local tSinceLastFrame = 0

-- Tamaño del jugador--

player.scaleX = -3
player.scaleY = 3

player.w = player.animationFrames[currentFrame]:getWidth() * math.abs(player.scaleX)
player.h = player.animationFrames[currentFrame]:getHeight() * math.abs(player.scaleY)
player.x = W * 0.05
player.y = (H * 0.5) - (player.h * 0.5)
player.speed = 350

local minX = 0
local minY = 0
local maxX = W * 0.9
local maxY = H * 0.9

-- Color del jugador--

color = {
    red = 1,
    green = 1,
    blue = 1,
 }

function player.update(dt)

-- Update del jugador--

    tSinceLastFrame = tSinceLastFrame + dt
    if (tSinceLastFrame >= tBtwnFrames) then
        currentFrame = (currentFrame % 4) + 1
        tSinceLastFrame = 0
    end

-- Controles del jugador--

    local dx, dy = 0, 0
    local isDown = love.keyboard.isDown
    if isDown("right") and (player.x + player.w < maxX) then
        dx = 1
    end
    if isDown("left") and player.x > minX then
        dx = -1
    end
    if isDown("down") and (player.y + player.h < maxY) then
      dy = 1
    end
    if isDown("up") and player.y > minY then
        dy = -1
    end
    
    local magnitude = math.sqrt(dx ^ 2 + dy ^ 2)
    if magnitude == 0 then
        dx, dy = 0, 0
    else
        dx, dy = dx / magnitude, dy / magnitude
    end

    player.x = player.x + (player.speed * dx * dt)
    player.y = player.y + (player.speed * dy * dt)
    player.LHS = player.x + (player.w * 0.375)
    player.RHS = player.x + (player.w * 0.825)
    player.top = player.y + (player.h * 0.15)
    player.bottom = player.y + (player.h * 0.85)

    player:unTint()
end

function player:tintRed()

-- Si el jugador toca al enemigo se vuelve rojo--

    color.green = 0
    color.blue = 0
end

function player:unTint()

-- Si deja de tocarlo vuelve a su estado original--

    color.red = 1
    color.green = 1
    color.blue = 1
end

function player.draw()

-- Dibujar jugador--

    love.graphics.setColor(color.red, color.green, color.blue)
    love.graphics.draw( 
        player.animationFrames[currentFrame], player.x, player.y, 0,
        player.scaleX, player.scaleY, player.w / math.abs(player.scaleX)
    )
end 

return player