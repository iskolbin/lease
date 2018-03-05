local Ease = require('ease')

local EASERS = {}
for name, f in pairs( Ease ) do
	if name ~= 'Linear' and name ~= 'Interpolation' then
		EASERS[#EASERS+1] = name
	end
end
table.sort( EASERS )
EASERS[#EASERS+1] = 'Linear'

local t = 0
local PERIOD = 1
local STEPS = 100
local MARGIN_X, MARGIN_Y = 10, 25
local GAP, SCALE = 25, 70
local PER_ROW = 6

local function drawPlot( i, name, f, t )
	local row, col = math.floor((i-1) / PER_ROW), (i-1) % PER_ROW
	local x0, y0 = MARGIN_X + col * SCALE + col * GAP, MARGIN_Y + row * SCALE + row * GAP
	love.graphics.print( name, x0 + 1, y0 - MARGIN_Y )
	local dt = 1/STEPS 
	for i = 0, STEPS do
		love.graphics.points( x0 + i*dt*SCALE, y0 + f(i*dt)*SCALE)
	end
	love.graphics.setPointSize( 3 )
	love.graphics.setColor( 255, 0, 0 )
	love.graphics.points( x0 + t*SCALE, y0 + f(t)*SCALE ) 
	love.graphics.setPointSize( 1 )
	love.graphics.setColor( 255, 255, 255 )
end

function love.update( dt )
	t = t + dt
	if t > PERIOD then
		t = 0
	end
end

function love.draw()
	for i, name in ipairs( EASERS ) do
		drawPlot( i, name, Ease[name], t/PERIOD )
	end
end
