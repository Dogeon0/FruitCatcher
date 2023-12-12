Obstacle = Class{}

function Obstacle:init()
    self.width = 20
    self.height = 20
    self.x = math.random(0,VIRTUAL_WIDTH)
    self.y = -30
    self.dy = 70
    self.dx = 0
    self.skin = math.random(4)
    self.rotation = 0
    self.rt = 2
end

function Obstacle:update(dt)
    
    self.rotation = self.rotation + (self.rt * dt)
    self.y = self.y + (self.dy * dt)

    if self.rotation > 360 then 
        self.rotation = 0 
    end

end

function Obstacle:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 
    return true
end



function Obstacle:render()
    love.graphics.draw(gTextures['Obstacles'], gFrames['Obstacles'][self.skin],
    self.x, self.y,self.rotation,1,1,self.width / 2,self.height / 2 )
end