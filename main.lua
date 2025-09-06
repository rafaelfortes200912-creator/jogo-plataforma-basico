-- variáveis
local box = 32

local cat = {
    x = 100,
    y = 100,
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
    y = 600,
    w = 1400,
    h = 200
}


function col_cima(a,b)
  if a.x < b.x + b.w and
    a.x + a.w > b.x and
    a.y < b.y + b.h and
    a.y + a.h > b.y then
    a.y = b.y - a.h
    cat.speedY = 0
    onground = true
else
    onground = false
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

    function col_direita(a,b)
  if a.x < b.x + b.w and
    a.x + a.w > b.x and
    a.y < b.y + b.h and
    a.y + a.h > b.y then
    a.x = b.x - a.w
    cat.speedX = 0
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

end

function love.keypressed(key)
    if key == "space" and onground then
        cat.speedY = cat.jump_power
    end
end

function love.draw()
    love.graphics.rectangle("line", chao.x, chao.y, chao.w, chao.h)
    love.graphics.rectangle("fill", cat.x, cat.y, cat.w, cat.h)

end