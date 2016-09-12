local auxiliar = {}

local char = {
  image = nil,
  x     = 400,
  y     = 475,
  w     = 85,
  h     = 90
}

local enemyW = 100
local enemyH = 77

createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

enemies = {}

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

deaths = 0
isAlive = true



function love.load () -- ibagens
  if arg[#arg] == "-debug" then require("mobdebug").start() end

  waterblock = love.graphics.newImage("water-block.png")
  grassblock = love.graphics.newImage('grass-block.png')
  stoneblock = love.graphics.newImage('stone-block.png')
  gameover = love.graphics.newImage('game-over.png')

  enemyImg = love.graphics.newImage('enemy-bug.png')
  char.image = love.graphics.newImage('chargirl.png')

  for i=0, 23, 1 do
    newEnemy = { x = math.random()*800, y = math.random()*1000, img = enemyImg } -- inimigos por linha
    table.insert(enemies, newEnemy)
   end


end



function love.draw()
  local numrows = 6
  local numcols = 7

  auxiliar.bg(numrows,numcols)

  if isAlive then
    love.graphics.draw(char.image, char.x, char.y)
  else
    love.graphics.print("THIS PLAYER IS NO MORE! HE HAS CEASED TO BE! PRESS R/ESC TO RESTART/QUIT", 75, 15)
    love.graphics.print("DEATH COUNT: "..deaths, 200, 30)
    love.graphics.draw(gameover, 0, 150)
    --love.graphics.setColor(255, 0, 0)
    enemies = {}
    if love.keyboard.isDown('r') then
      enemies = {}
      createEnemyTimer = createEnemyTimerMax
      char.x = 50
      char.y = 710
      isAlive = true
    end
  end

  auxiliar.wins()

  for i, enemy in ipairs(enemies) do
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end


end



function love.update(dt)

  auxiliar.teclado()

  createEnemyTimer = createEnemyTimer - (1 * dt) -- respawn
  if createEnemyTimer < 0 then
	   createEnemyTimer = createEnemyTimerMax

     newEnemy = { x = 0, y = math.random()*1000, img = enemyImg } -- inimigos por linha
     table.insert(enemies, newEnemy)
   end

  for i, enemy in ipairs(enemies) do -- movimentos do inimigo
    enemy.x = enemy.x + (150 * dt)
  end

  for i, enemy in ipairs(enemies) do
  	if CheckCollision(enemy.x, enemy.y, enemyW, enemyH, char.x, char.y, char.w, char.h)
  	and isAlive then
  		table.remove(enemies, i)
  		isAlive = false
      deaths = deaths + 1
  	end
  end


end



auxiliar.bg = function(numrows, numcols) -- texturas do fundo
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

auxiliar.teclado = function() -- movimentos possiveis do jogador
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

auxiliar.wins = function() -- tela de vitoria
  if char.y < 100 then
    --auxiliar.fonte() se descomentar com o auxiliar.fonte rolando vai bugar
    love.graphics.print("--YOU DIED--", 250, 15)
    love.graphics.print("Life is meaningless, death is a victory. Press R to restart", 225, 30)
    love.graphics.setColor(255, 0, 0)
    enemies = {}
  end
end

auxiliar.fonte = function() -- coisa desnecessaria do lua delet this
  font = love.graphics.newImageFont("Fonte.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font)
end

auxiliar.restart = function() -- pe lanza
  char.x = 400
  char.y = 400
  love.graphics.setColor(255, 255, 255)
end
