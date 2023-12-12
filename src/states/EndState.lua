EndState = Class{__includes = BaseState}

function EndState:init(points)
    self.tiles = {}
    self.points = points
    self:generateTiles(bgID)

end

function EndState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['select']:play()
        gStateStack:pop()
        randomBG()
        gStateStack:push(StartState(canInput))
        gStateStack:push(FadeState({r = 20, g = 20, b = 20},0.5,function() end))
    end
end


function EndState:generateTiles(id)
    for y = 1, SCREEN_HEIGHT do
        table.insert(self.tiles, {})

        for x = 1, SCREEN_WIDTH do
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end

    
end

function EndState:render()

    for y = 1, SCREEN_HEIGHT do
        for x = 1, SCREEN_WIDTH do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE, 
                (y - 1) * TILE_SIZE)
        end
    end
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1/255,1/255,1/255,1)
    love.graphics.printf("YOU LOSE", -2, VIRTUAL_HEIGHT / 2 - 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255,255,255,1)
    love.graphics.printf("YOU LOSE", 0, VIRTUAL_HEIGHT / 2 -50, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1/255,1/255,1/255,1)
    love.graphics.printf("You made: ".. self.points .. " points", -2, VIRTUAL_HEIGHT / 2 - 102, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255,255,255,1)
    love.graphics.printf("You made: ".. self.points .. " points", 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    
end
