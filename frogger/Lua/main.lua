local auxiliar ={}

local char = {
  image = nil,
  x     = 400,
  y     = 475,
}

function love.load ()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  waterblock = love.graphics.newImage("water-block.png")
  grassblock = love.graphics.newImage('grass-block.png')
  stoneblock = love.graphics.newImage('stone-block.png')
  
  char.image = love.graphics.newImage('chargirl.png')
  
end
function love.draw() 
  local numrows = 6
  local numcols = 7
  
  auxiliar.bg(numrows,numcols)
  
  love.graphics.draw(char.image, char.x, char.y)
  auxiliar.wins()
end

function love.update()
  
  auxiliar.teclado()
  
end

auxiliar.bg = function(numrows, numcols) 
  for row = 0, numrows do
    for col = 0, numcols do
      if row < 1 then
        love.graphics.draw(waterblock, col * 100, row * 80)
      elseif row < 3 then
        love.graphics.draw(stoneblock, col * 100, row * 80)
      else
        love.graphics.draw(grassblock, col * 100, row * 80)
      end
    end
  end
end

auxiliar.teclado = function()
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
  
  if love.keyboard.isDown('r') then
    auxiliar.restart()
  end
  
  if love.keyboard.isDown('a', 'left')then
    if char.x > 0 then
      char.x = char.x - 10
    end
  elseif love.keyboard.isDown('d', 'right')then
    if char.x < (love.graphics.getWidth() - char.image:getWidth()) then
      char.x = char.x + 10
    end
  elseif love.keyboard.isDown('w', 'up') then
    if char.y > 0 then
      char.y = char.y - 10
    end
  elseif love.keyboard.isDown('s', 'down') then
    if char.y < (love.graphics.getHeight() - char.image:getHeight()) then
      char.y = char.y + 10
    end
  end
end

auxiliar.wins = function()
  if char.y < 100 then
    auxiliar.fonte()
    love.graphics.print("--YOU DIED--", 250, 15)
    love.graphics.print("Press R to restart", 225, 30)
    love.graphics.setColor(255, 0, 0)
  end
end

auxiliar.fonte = function()
  font = love.graphics.newImageFont("Fonte.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font)
end

auxiliar.restart = function()
  char.x = 400
  char.y = 400
  love.graphics.setColor(255, 255, 255)
end
