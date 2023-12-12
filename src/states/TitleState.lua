TitleState = Class{__includes = BaseState}

function TitleState:init()
    randomBG()
    self.tiles = {}
    self:generateTiles(bgID)
    tween = { yCoord = 0 }
    canInput = false
    gSounds['menuMusic']:setLooping(true)
    gSounds['menuMusic']:play()
    
end

function TitleState:update(dt)
    Timer.tween(2,{ 
        [tween] = { yCoord = -VIRTUAL_HEIGHT } 
    })
    :finish(function () 
        canInput = true
    end)


    if canInput == true then 
        gStateStack:pop() 
        gStateStack:push(StartState(canInput))
        gStateStack:push(FadeState({r = 20, g = 20, b = 20},0.5,function() end)) 
    end
        
end

function TitleState:generateTiles(id)
    for y = 1, SCREEN_HEIGHT do
        table.insert(self.tiles, {})

        for x = 1, SCREEN_WIDTH do
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function TitleState:render()
    for y = 1, SCREEN_HEIGHT do
        for x = 1, SCREEN_WIDTH do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE, 
                (y - 1) * TILE_SIZE)
        end
    end

    love.graphics.setColor(1/255,1/255,1/255,1)
    love.graphics.rectangle('fill', 0, tween.yCoord, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end
