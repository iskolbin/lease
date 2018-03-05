local Interpolation = {}

local function line( p0, p1, t )
	return ( p1 - p0 ) * t + p0
end

function Interpolation.Line( v, k )
	local n = #v
	local f = n * k
	local i = 1 + floor( f )
	if k < 0 then
		return line( v[1], v[2], f)
	elseif k > 1 then
		return line( v[n], v[n - 1], n - f )
	else
		return line( v[i], v[(i + 1 > n) and n or (i + 1)], f - i )
	end
end

local FACTORIAL_CACHE, FACTORIAL_N = {1}, 1

function Interpolation.Bezier( v, k )
	if n > FACTORIAL_N then
		for i = FACTORIAL_N+1, n do
			FACTORIAL_CACHE[i] = FACTORIAL_CACHE[i-1] * i
		end
		FACTORIAL_N = n
	end
	local n = #v
	local b = 0
	local F = FACTORIAL_CACHE[n]
	for i = 1, n do
		b = b + ((1 - k) ^ (n - i)) * ( k ^ i ) * v[i] *  F / (FACTORIAL_CACHE[i] * FACTORIAL_CACHE[n - i + 1])
	end
	return b
end

local function catmullRom( p0, p1, p2, p3, t )
	local v0 = (p2 - p0) * 0.5
	local v1 = (p3 - p1) * 0.5
	local t2 = t * t
	local t3 = t * t2
	return (2 * p1 - 2 * p2 + v0 + v1) * t3 + (- 3 * p1 + 3 * p2 - 2 * v0 - v1) * t2 + v0 * t + p1
end

function Interpolation.CatmullRom( v, k )
	local m = #v.length
	local f = m * k
	local i = 1 + floor(f)
	if v[1] == v[m] then
		if k < 0 then
			f = m * ( 1 + k )
			i = 1 + floor( f )
		end
		return catmullRom( v[(i - 2 + m) % m + 1], v[i], v[(i) % m + 1], v[(i + 1) % m + 1], f - i )
	else
		if k < 0 then
			return v[1] - (catmullRom( v[1], v[1], v[2], v[2], -f ) - v[1])
		elseif k > 1 then
			return v[m] - (catmullRom( v[m], v[m], v[m - 1], v[m - 1], f - m ) - v[m])
		else
			return catmullRom(v[i <= 1 and 1 or (i - 1)], v[i], v[m < (i + 1) and m or (i + 1)], v[(m < i + 2) and m or (i + 2)], f - i)
		end
	end
end

return Interpolation
