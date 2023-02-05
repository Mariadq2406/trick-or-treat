--Enemigo--

function newEnemy(x)
    require = ("player")
    local enemy = {}

    enemy.x = x

-- Animación del enemigo--

    enemy.animationFrames = {}
    for i = 1, 4 do
        local frame = love.graphics.newImage("assets/images/enemy/" .. i .. ".png")
        table.insert(enemy.animationFrames, frame)
    end
    local currentFrame = 1
    local tBtwnFrames = 0.1
    local tSinceLastFrame = 0

-- Tamaño del enemigo--

    enemy.scaleX = 2.5
    enemy.scaleY = 2.5
    enemy.w = enemy.animationFrames[currentFrame]:getWidth() * math.abs(enemy.scaleX)
    enemy.h = enemy.animationFrames[currentFrame]:getHeight() * math.abs(enemy.scaleY)
    enemy.y = love.math.random(0, H - enemy.h)
    enemy.speed = love.math.random(enemyMinSpeed, enemyMaxSpeed)

    function enemy.update(dt)

-- Update del enemigo--

        tSinceLastFrame = tSinceLastFrame + dt
        if (tSinceLastFrame >= tBtwnFrames) then
            currentFrame = (currentFrame % 4) + 1
            tSinceLastFrame = 0
        end
        enemy.x = enemy.x - (enemy.speed * dt)

        if (enemy.x + enemy.w < 0) then
            enemy.x = W + love.math.random(10, 60)
            enemy.y = love.math.random(0, (H * 0.9) - enemy.h)
            enemy.speed = love.math.random(enemyMinSpeed, enemyMaxSpeed)
        end
        
-- Colisión--

         enemy.LHS = enemy.x + (enemy.w * 0.2)
         enemy.RHS = enemy.x + (enemy.w * 0.75)
         enemy.top = enemy.y + (enemy.h * 0.1)
         enemy.bottom = enemy.y + (enemy.h * 0.85)
         if ((player.LHS <= enemy.RHS and player.RHS >= enemy.LHS) and 
             (player.top <= enemy.bottom and player.bottom >= enemy.top)) then
                player.tintRed()
                health.current = health.current - 0.05
                if health.current <= 1 then 
                    state = 2
        end
        love.filesystem.write("highscore.txt", highscore)
    end
end

function enemy.draw()

-- Dibujar enemigo--

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
        enemy.animationFrames[currentFrame], enemy.x, enemy.y, 0, 
        enemy.scaleX, enemy.scaleY
    )
end

return enemy
end