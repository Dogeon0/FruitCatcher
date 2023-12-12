FadeState = Class{__includes = BaseState}

function FadeState:init(color, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.time = time
    Timer.tween((self.time / 2), {
        [self] = {opacity = 1}
    })
    :finish(function()
        Timer.tween((self.time / 2), {
            [self] = {opacity = 0}
        })
        :finish(function()
            gStateStack:pop()
            onFadeComplete()
        end)
    end)
end

function FadeState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end