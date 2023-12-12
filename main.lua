require 'src/Dependencies'


function love.load()
    musicVol = {vol = 0.8}
    love.window.setTitle('Fruit Catcher')
    imageData = love.image.newImageData('graphics/icon.png')
    love.window.setIcon(imageData)
    love.graphics.setDefaultFilter('nearest','nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(TitleState())

    love.keyboard.keysPressed = {}

    
end

function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function stopMusic() 
    gSounds['menuMusic']:stop()
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end