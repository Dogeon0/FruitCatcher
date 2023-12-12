PlayState = Class{__includes = BaseState}

function PlayState:init()
    play = false
    lifeBar = {
        hp = 100,
        height = 5,
        width = VIRTUAL_WIDTH,
        x = 0,
        y = VIRTUAL_HEIGHT - 5
    }
    fruitVel = 0
    lifeSteal = 0.05
    difficulty = 1
    levelDisplay = 1
    points = 0
    hpRemoval = 5
    pointsToLevelUp = 3
    
    Timer.tween(3,{ [musicVol] = { vol = 0.5}, })
    :finish(function() 

    end)
    self.fruits = {}
    self.obstacles = {}
    basket = Basket()
    self.timer = 0
    self.tiles = {}
    tileRender = true
    self:generateTiles(bgID)
    count = 3
    counter = Timer.every(1,
        function()
            count = count - 1
        end)
        :limit(3) 
        :finish(function() play = true end)
end

function PlayState:update(dt)
    gSounds['menuMusic']:setVolume(musicVol.vol)
    if play == true then 
        self.timer = self.timer + dt   
        lifeBar.width = lifeBar.width - lifeSteal
        lifeBar.hp = lifeBar.width
        local fruitTypes = {'melon','banana','cherry','generic'}
        if self.timer > difficulty then
            local typeFruit = nil
            local k = math.random(100)
            local l = math.random(50)
            if k > 75 then
                local typeFruit = fruitTypes[math.random(3)]
                table.insert(self.fruits, Fruit{
                    dy = FRUIT_DEFS[typeFruit].fruitVelocity,
                    skin = FRUIT_DEFS[typeFruit].skin,
                    type = FRUIT_DEFS[typeFruit].type,
                    bounceWall = FRUIT_DEFS[typeFruit].bounceWall
                })
            else
                local typeFruit = fruitTypes[4]
                table.insert(self.fruits, Fruit{
                    dy = FRUIT_DEFS[typeFruit].fruitVelocity,
                    skin = math.random(4,14),
                    type = FRUIT_DEFS[typeFruit].type,
                    bounceWall = FRUIT_DEFS[typeFruit].bounceWall
                })
            end

            if l > 40 then
                local obstacle = Obstacle()
                table.insert(self.obstacles, obstacle)
            end
            self.timer = 0
        end
    end
    basket:update(dt)
    for k, fruit in pairs(self.fruits) do
        sound = math.random(4)
        fruit:update(dt)

        if fruit.y > VIRTUAL_HEIGHT + 2 then
            lifeBar.width = lifeBar.width - hpRemoval
            table.remove(self.fruits,k)
            gSounds['hurt']:stop()
            gSounds['hurt']:play()
        end 

        if fruit:collides(basket) then
            local lleve = 5
            gSounds['splat'..sound]:setVolume(0.4)
            gSounds['splat'..sound]:stop()
            gSounds['splat'..sound]:play()
            table.remove(self.fruits,k)
            if fruit.type == 'single' then
                lleve = 10
                points = points + 1
            elseif fruit.type == 'double' then
                lleve = 14
                points = points + 2
                gSounds['point']:setVolume(0.4)
                gSounds['point']:stop()
                gSounds['point']:play()
            elseif fruit.type == 'triple' then
                lleve = 18
                points = points + 3
                gSounds['point']:setVolume(0.4)
                gSounds['point']:stop()
                gSounds['point']:play()
            end 
            lifeBar.width = math.min(VIRTUAL_WIDTH,lifeBar.width + lleve)
        end

        

        if points >= pointsToLevelUp then
            LevelUp()
            
            if levelDisplay % 5  == 0 then
                fruitVel = fruitVel + 80
            end
        end


    end

    for k, obstacle in pairs(self.obstacles) do
        obstacle:update(dt)
    end

    if lifeBar.hp < 0.5 then
        gSounds['fail']:play()
        gStateStack:pop()
        gStateStack:push(EndState(points))
    end

    

end

function LevelUp()
    hpRemoval = hpRemoval + 5
    fruitVel = fruitVel + 30
    levelDisplay = levelDisplay + 1
    difficulty = difficulty - 0.05
    lifeSteal = lifeSteal + 0.002
    pointsToLevelUp = math.floor(pointsToLevelUp * 1.6) 
end



function PlayState:generateTiles(id)
    for y = 1, SCREEN_HEIGHT do
        table.insert(self.tiles, {})

        for x = 1, SCREEN_WIDTH do
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function PlayState:render()
    love.graphics.setFont(gFonts['large'])

    if tileRender == true then
        for y = 1, SCREEN_HEIGHT do
            for x = 1, SCREEN_WIDTH do
                local tile = self.tiles[y][x]
                love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                    (x - 1) * TILE_SIZE, 
                    (y - 1) * TILE_SIZE)
            end
        end
    end

    if count > 0 then
        --countdown
            love.graphics.setFont(gFonts['large'])
            love.graphics.setColor(1/255,1/255,1/255,1)
            love.graphics.printf(count, -1, VIRTUAL_HEIGHT / 2 - 131, VIRTUAL_WIDTH, 'center')
            love.graphics.setColor(255,255,255,1)
            love.graphics.printf(count, 0, VIRTUAL_HEIGHT / 2 - 130, VIRTUAL_WIDTH, 'center')
        --pointage
            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1/255,1/255,1/255,1)
            love.graphics.printf("2 points", 14, VIRTUAL_HEIGHT / 2 , VIRTUAL_WIDTH, 'center')
            love.graphics.setColor(255,255,255,1)
            love.graphics.printf("2 points", 15, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1/255,1/255,1/255,1)
            love.graphics.printf("3 points", 14, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
            love.graphics.setColor(255,255,255,1)
            love.graphics.printf("3 points", 15, VIRTUAL_HEIGHT / 2 + 31, VIRTUAL_WIDTH, 'center')
        --fruit images
            local fruitWidth = gTextures['fruitPoints']:getWidth()
            local fruitHeight = gTextures['fruitPoints']:getHeight()
            love.graphics.draw(gTextures['fruitPoints'],10,(VIRTUAL_HEIGHT/ 2))

        --controls
        love.graphics.setFont(gFonts['medium'])

        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("Controls:", -1, VIRTUAL_HEIGHT  - 81, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("Controls:", 0, VIRTUAL_HEIGHT  - 80, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("A to move left", -1, VIRTUAL_HEIGHT  - 61, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("A to move left", 0, VIRTUAL_HEIGHT  - 60, VIRTUAL_WIDTH, 'center')
    
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("D to move right", -1, VIRTUAL_HEIGHT  - 51, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("D to move right", 0, VIRTUAL_HEIGHT  - 50, VIRTUAL_WIDTH, 'center')
    
    else
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("POINTS:  "..points, -1, 9, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("POINTS:  "..points, 0, 10, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['large'])
        love.graphics.setColor(1/255,1/255,1/255,1)
        love.graphics.printf("LEVEL:  "..levelDisplay, -2, VIRTUAL_HEIGHT / 2 - 102, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255,255,255,1)
        love.graphics.printf("LEVEL:  "..levelDisplay, 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    end
    
    
    for k, fruit in pairs(self.fruits) do
        fruit:render()
    end
    basket:render()
    love.graphics.setColor(255/255,1/255,1/255,1)
    love.graphics.rectangle("fill", lifeBar.x,lifeBar.y, lifeBar.width,lifeBar.height)
end
