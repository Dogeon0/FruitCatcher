Class = require 'lib/class'
push = require 'lib/push'
Event = require 'lib/knife.event'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/fruit_defs'

require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/FadeState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/EndState'
require 'src/states/TitleState'

require 'src/Obstacle'
require 'src/Basket'
require 'src/Fruit'
require 'src/Util'
require 'src/Button'

function randomBG()
    bgID = math.random(5)
end

gTextures = {
    ['fruits'] = love.graphics.newImage('graphics/fruits.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['menu'] = love.graphics.newImage('graphics/menubg.png'),
    ['tiles'] = love.graphics.newImage('graphics/tilemap.png'),
    ['basket'] = love.graphics.newImage('graphics/basket.png'),
    ['obstacles'] = love.graphics.newImage('graphics/obstacles.png'),
    ['title'] = love.graphics.newImage('graphics/TITLE.png'),
    ['Button'] = love.graphics.newImage('graphics/Buttons.png'),
    ['fruitPoints'] = love.graphics.newImage('graphics/fruitPoint.png'),
    ['controlButton'] = love.graphics.newImage('graphics/controlButton.png')

}

gSounds = {
    ['select'] = love.audio.newSource('sounds/vgmenuselect.wav','static'),
    ['menuMusic'] = love.audio.newSource('sounds/music/menu.wav','static'),
    ['fail'] = love.audio.newSource('sounds/finalHit.wav','static'),
    ['point'] = love.audio.newSource('sounds/point.wav','static'),
    ['splat1'] = love.audio.newSource('sounds/splash/splat1.wav','static'),
    ['splat2'] = love.audio.newSource('sounds/splash/splat2.wav','static'),
    ['splat3'] = love.audio.newSource('sounds/splash/splat3.wav','static'),
    ['splat4'] = love.audio.newSource('sounds/splash/splat4.wav','static'),
    ['hurt'] = love.audio.newSource('sounds/hurt.wav','static')

}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gFrames = {
    ['fruits'] = SameSizeQuads(gTextures['fruits'],20,20),
    ['tiles'] = SameSizeQuads(gTextures['tiles'],16,16),
    ['obstacles'] = SameSizeQuads(gTextures['obstacles'],16,16),
    ['buttons'] = SameSizeQuads(gTextures['Button'],16,16),
    ['controls'] = SameSizeQuads(gTextures['controlButton'],16,16)
}



