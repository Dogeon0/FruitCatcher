StartState = Class{__includes = BaseState}

function StartState:init(canInput)
    muteMusic = false
    self.canInput = canInput
    self.tiles = {}
    self:generateTiles(bgID)
    self.buttons = {}
    volButtonX = VIRTUAL_WIDTH - 20
    volButtonY = VIRTUAL_HEIGHT - 20
    table.insert(self.buttons,Button{
        x = volButtonX,
        y = volButtonY,
        width = 0,
        height = 0,
        type = volBttn,
        skin = 1
    })
end

function StartState:update(dt)
    if self.canInput then
        
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            gSounds['select']:play()
            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(FadeState({r = 20, g = 20, b = 20},0.5,function() end))


        elseif love.keyboard.wasPressed('space') and muteMusic == false then
            gSounds['menuMusic']:pause()
            muteMusic = true
            for k, button in pairs(self.buttons) do
               button.skin = 2
            end


        elseif love.keyboard.wasPressed('space') and muteMusic == true then            
            gSounds['menuMusic']:play()
            muteMusic = false
            for k, button in pairs(self.buttons) do
                button.skin = 1
            end

        end


        for k, button in pairs(self.buttons) do
            button:update(dt)
        end
    end

    

end


function StartState:generateTiles(id)
    for y = 1, SCREEN_HEIGHT do
        table.insert(self.tiles, {})

        for x = 1, SCREEN_WIDTH do
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function StartState:render()
    

    for y = 1, SCREEN_HEIGHT do
        for x = 1, SCREEN_WIDTH do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE, 
                (y - 1) * TILE_SIZE)
        end
    end
    --press enter to text
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("press ENTER to", -1,(VIRTUAL_HEIGHT/ 2) + 30, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("press ENTER to", 0,(VIRTUAL_HEIGHT/ 2) + 31, VIRTUAL_WIDTH, 'center')

    --play text
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("PLAY", -1,(VIRTUAL_HEIGHT/ 2) + 44, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("PLAY", 0,(VIRTUAL_HEIGHT/ 2) + 45, VIRTUAL_WIDTH, 'center')
    
    --titleImage
        local titleWidth = gTextures['title']:getWidth()
        local titleHeight = gTextures['title']:getHeight()
        love.graphics.draw(gTextures['title'],
        (VIRTUAL_WIDTH / 2 ) ,(VIRTUAL_HEIGHT/ 2) - 30,
        0,0.4,0.4,titleWidth / 2,titleHeight /2 )

    --space to mute text
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("SPACE",volButtonX - 8,volButtonY - 8,VIRTUAL_WIDTH,'left')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("SPACE", volButtonX - 7,volButtonY - 7,VIRTUAL_WIDTH,'left')
    

    for k, button in pairs(self.buttons) do
        button:render()
    end
end
