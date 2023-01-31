
local GUI = {}
local Player = require("player")

function GUI:load()

-- Vida--

    health = {current = 3, max = 3}
    
-- Corazones--

    hearts = {}
    hearts.img = love.graphics.newImage("assets/images/heart.png")
    hearts.width = hearts.img:getWidth()
    hearts.height = hearts.img:getHeight()
    hearts.x = W * 0.80
    hearts.y = 20
    hearts.scale = 1.5
    hearts.spacing = hearts.width * hearts.scale + 30
   end

function GUI:update(dt)
end

function GUI:draw()

-- Dibujar corazones --

   self:displayHearts()
end

function GUI:displayHearts()
   for i=1, health.current do
      local x = hearts.x + hearts.spacing * i
      love.graphics.setColor(0,0,0,0.5)
      love.graphics.draw(hearts.img, x + 2, hearts.y + 2, 0, hearts.scale, hearts.scale)
      love.graphics.setColor(1,1,1,1)
      love.graphics.draw(hearts.img, x, hearts.y, 0, hearts.scale, hearts.scale)
   end
end

return GUI