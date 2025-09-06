-- variáveis
local box = 32
local cameraX = 0
local cameraY = 0

local cat = {
    x = 750,
    y = 610,
    w = 32,
    h = 32,
    speedX = 200,
    jump_power = -550,
    speedY = 30
}

-- gravidade
local gravity = 800
local floorY = 600
local pos_floorx = -30
local onground = false

local chao = {
    x = -30,
    y = 650,
    w = 1800,
    h = 1000
}
 local wall_ivs ={
    {x = 223, y = -800, w = 32, h = 1500},
    {x = 1238, y = -800, w = 32, h = 1500},
 }

 local block = {
    {x = 408, y = 500, w = wall_ivs[1].x - 408, h = chao.y - 500},
    {x = 332, y = 500, w = 32, h = 32},
 }

function col_cima(a,b)
  if a.x < b.x + b.w and
    a.x + a.w > b.x and
    a.y < b.y + b.h and
    a.y + a.h > b.y then
    a.y = b.y - a.h
    cat.speedY = 0
    return true   
else
    return false
end
end

    function col_baixo(a,b)
  if a.x < b.x + b.w and
    a.x + a.w > b.x and
    a.y < b.y + b.h and
    a.y + a.h > b.y then
    a.y = b.y + a.h
    cat.speedY = 0
    cat.jump_power = 0
    onground = false
    end
end

function col_direita(a, b)
  if a.x + a.w > b.x and       -- o lado direito do player passou do lado esquerdo do bloco
     a.x < b.x and             -- o lado esquerdo do player está antes do bloco
     a.y + a.h > b.y and       -- colisão vertical
     a.y < b.y + b.h then

     a.x = b.x - a.w           -- reposiciona na borda
  end
end

function col_esquerda(a, b)
  if a.x < b.x + b.w and       -- o lado esquerdo do player passou do lado direito do bloco
     a.x + a.w > b.x + b.w and -- o lado direito do player está depois do bloco
     a.y + a.h > b.y and       -- colisão vertical
     a.y < b.y + b.h then

     a.x = b.x + a.w           -- reposiciona na 
  end
end

function love.load()
    love.window.setTitle("Cat Game")
    love.window.setMode(1000, 700)
end


function love.update(dt)
    cat.speedY = cat.speedY + gravity * dt
    cat.y = cat.y + cat.speedY * dt
 
if love.keyboard.isDown("a") then
    cat.x = cat.x - cat.speedX * dt
end

if love.keyboard.isDown("d") then
    cat.x = cat.x + cat.speedX * dt
end

    col_cima(cat, chao)

    col_direita(cat, wall_ivs[2])
    col_esquerda(cat, wall_ivs[1])

    --col_cima(cat, block[1])
    col_esquerda(cat, block[1])

    cameraX = cat.x - 500
end

function love.keypressed(key)
    if key == "space" and onground then
        cat.speedY = cat.jump_power
    end
end

function love.draw()


    love.graphics.push()
    love.graphics.translate(-cameraX, 0)

    love.graphics.setColor(1, 1, 1) -- branco
    love.graphics.rectangle("line", chao.x, chao.y, chao.w, chao.h)
    love.graphics.rectangle("fill", cat.x, cat.y, cat.w, cat.h)
    --love.graphics.rectangle("fill", wall_ivs[1].x, wall_ivs[1].y, wall_ivs[1].w, wall_ivs[1].h)
    --love.graphics.rectangle("fill", wall_ivs[2].x, wall_ivs[2].y, wall_ivs[2].w, wall_ivs[2].h)
    love.graphics.rectangle("fill", block[1].x, block[1].y, block[1].w, block[1].h)

    love.graphics.pop()

    -- posições x e y
    love.graphics.print("X: " .. math.floor(cat.x) .. "  Y: " .. math.floor(cat.y), 10, 10)
end