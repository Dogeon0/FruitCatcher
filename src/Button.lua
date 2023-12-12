Button = Class{}

function Button:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.isPressed = false
    self.type = def.type
    self.skin = def.skin 
end


function Button:update()

end


function Button:render()
    love.graphics.draw(gTextures['Button'], gFrames['buttons'][self.skin],
    self.x, self.y)
end