local PI, HALF_PI, FIVE_PI, sin, cos, sqrt = math.pi, math.pi / 2, 5 * math.pi, math.sin, math.cos, math.sqrt

local Ease = {}

function Ease.StepIn( k ) 
	return k < 1 and 0 or 1
end

function Ease.StepOut( k ) 
	return k > 0 and 1 or 0
end

function Ease.StepInOut( k ) 
	return k < 0.5 and 0 or 1
end

function Ease.Linear( k ) 
	return k
end

function Ease.QuadraticIn( k )
	return k * k
end

function Ease.QuadraticOut( k ) 
	return k * (2 - k)
end

function Ease.QuadraticInOut( k ) 
	k = k + k
	if k < 1 then 
		return 0.5 * k * k
	end
	k = k - 1
	return -0.5 * ( k * (k - 2) - 1 )
end

function Ease.CubicIn( k )
	return k * k * k
end

function Ease.CubicOut( k )
	k = k - 1
	return k * k * k + 1
end

function Ease.CubicInOut( k )
	k = k + k
	if k < 1 then
		return 0.5 * k * k * k
	end
	k = k - 2
	return 0.5 * (k * k * k + 2)
end

function Ease.QuarticIn( k )
	k = k * k
	return k * k
end

function Ease.QuarticOut( k )
	k = k - 1
	return 1 - k * k * k * k
end

function Ease.QuarticInOut( k )
	k = k + k
	if k < 1 then
		k = k * k
		return 0.5 * k * k
	end
	k = k - 2
	k = k * k
	return - 0.5 * (k * k - 2)
end

function Ease.QuinticIn( k )
	local k1 = k * k
	return k1 * k1 * k
end

function Ease.QuinticOut( k )
	k = k - 1
	local k1 = k * k
	return k1 * k1 * k + 1
end

function Ease.QuinticInOut( k )
	k = k + k
	if k < 1 then
		local k1 = k * k
		return 0.5 * k1 * k1 * k
	end
	k = k - 2
	local k1 = k * k
	return 0.5 * (k1 * k1 * k + 2)
end

function Ease.SinusoidalIn( k )
	return 1 - cos( k * HALF_PI )
end

function Ease.SinusoidalOut( k )
	return sin( k * HALF_PI )
end

function Ease.SinusoidalInOut( k )
	return 0.5 * ( 1 - cos( PI * k ))
end

function Ease.ExponentialIn( k )
	return k == 0 and 0 or 1024^(k - 1)
end

function Ease.ExponentialOut( k )
	return k == 1 and 1 or 1 - 2^(-10 * k)
end

function Ease.ExponentialInOut( k )
	if k == 0 then
		return 0
	elseif k == 1 then
		return 1
	else
		k = k * k
		if k < 1 then
			return 0.5 * 1024^( k - 1 )
		else
			return 0.5 * (-2^(- 10 * (k - 1)) + 2 )
		end
	end
end

function Ease.CircularIn( k )
	return 1 - sqrt( 1 - k * k )
end

function Ease.CircularOut( k )
	k = k - 1
	return sqrt( 1 - k * k )
end

function Ease.CircularInOut( k )
	k = k + k
	if k < 1 then 
		return -0.5 * ( sqrt(1 - k * k) - 1 )
	end
	k = k - 2
	return 0.5 * ( sqrt( 1 - k * k) + 1 )
end

function Ease.ElasticIn( k )
	if k == 0 then 
		return 0
	elseif k == 1 then
		return 1
	end
	return -2^(10 * (k - 1)) * sin( (k - 1.1) * FIVE_PI )
end

function Ease.ElasticOut( k )
	if k == 0 then
		return 0
	elseif k == 1 then
		return 1
	end
	return 2^( -10 * k ) * sin( (k - 0.1) * FIVE_PI ) + 1
end

function Ease.ElasticInOut( k )
	if k == 0 then
		return 0
	elseif k == 1 then
		return 1
	end
	k = k + k
	if k < 1 then 
		return -0.5 * 2^(10 * (k - 1)) * sin( (k - 1.1) * FIVE_PI )
	end
	return 0.5 * 2^(-10 * (k - 1)) * sin( (k - 1.1) * FIVE_PI ) + 1
end

function Ease.BackIn( k )
	return k * k * (2.70158 * k - 1.70158)
end

function Ease.BackOut( k )
	k = k - 1
	return k * k * (2.70158 * k + 1.70158) + 1
end

function Ease.BackInOut( k )
	k = k + k
	if k < 1 then
		return 0.5 * (k * k * (3.5949095 * k - 2.5949095))
	end
	k = k - 2
	return 0.5 * (k * k * (3.5949095 * k + 2.5949095) + 2)
end

local function BounceOut( k )
	if k < 1 / 2.75 then
		return 7.5625 * k * k
	elseif k < 2 / 2.75 then
		k = k - 1.5/2.75
		return 7.5625 * k * k + 0.75
	elseif k < 2.5 / 2.75 then
		k = k - 2.25/2.75
		return 7.5625 * k * k + 0.9375
	else
		k = k - 2.625/2.75
		return 7.5625 * k * k + 0.984375
	end
end

local function BounceIn( k )
	return 1 - BounceOut( 1 - k )
end

Ease.BounceIn = BounceIn

Ease.BounceOut = BounceOut

function Ease.BounceInOut( k )
	if k < 0.5 then
		return BounceIn(k + k) * 0.5
	end
	return BounceOut(k + k - 1) * 0.5 + 0.5
end

return Ease
