Fruit = Class{}

function Fruit:init(def)
    self.width = 16
    self.height = 16
    self.x = math.random(0,VIRTUAL_WIDTH)
    self.y = -30
    self.dy = def.dy + fruitVel
    self.skin = def.skin
    self.rotation = 0
    self.rt = 2
    self.type = def.type
    self.bounceWall = def.bounceWall
    if self.bounceWall == true then
        self.dx = math.random(-200,200)
    else
        self.dx = 0
    end
end

function Fruit:update(dt)
    
    self.rotation = self.rotation + (self.rt * dt)
    self.y = self.y + (self.dy * dt)
    self.x = self.x + (self.dx * dt)

    if self.rotation > 360 then 
        self.rotation = 0 
    end

    if self.x <= 8 then
        self.x = 8
        self.dx = -self.dx
    end

    if self.x >= VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
    end

end

function Fruit:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 
    return true
end



function Fruit:render()
    love.graphics.draw(gTextures['fruits'], gFrames['fruits'][self.skin],
    self.x, self.y,self.rotation,1,1,self.width / 2,self.height / 2 )
end