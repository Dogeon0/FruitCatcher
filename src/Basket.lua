Basket = Class{}

function Basket:init()
    self.width = 32
    self.height = 16
    self.x = VIRTUAL_WIDTH /2 
    self.y = VIRTUAL_HEIGHT - 30
    self.dy = 0
    self.dx = 0
    direction = ""
    canGo = true
end

function Basket:update(dt)
    --movement

            if love.keyboard.isDown('a') or love.keyboard.isDown('left')then
                direction = "left"
            elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
                direction = "right"
            end

    
        if direction == "left" then
            self.dx = -BASKET_SPEED

        elseif direction == "right" then
            self.dx = BASKET_SPEED

        else
            self.dx = 0
        end


        if self.dx < 0 then
            self.x = math.max(0, self.x + self.dx * dt)
        else
            self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
        end
end

function Basket:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 
    return true
end



function Basket:render()
    love.graphics.draw(gTextures['basket'],
    self.x, self.y,0,1,1)
end