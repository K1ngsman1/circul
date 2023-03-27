local scx, scy = guiGetScreenSize( )
local pX, pY = scx / 2, scy / 2
local lastTick = getTickCount( )
local update_interval = false

local gap_to_icon = { }
for i = 1, 5 do
	gap_to_icon[ i ] = 0
end

showCursor( true )
addEventHandler( "onClientRender", root, function( )
	local currTick = getTickCount( )
	local progress = getEasingValue( math.clamp( 0.0, ( currTick - lastTick ) / 399, 1.0 ), "OutQuad" )

	for i = 1, 5 do
		local rad_angle = math.rad( 72 * i - 135 )

		local x = pX + math.cos( rad_angle ) * 175 - ( 150 / 2 )
		local y = pY + math.sin( rad_angle ) * 175 - ( 150 / 2 )


		dxDrawImage( x, y, 150, 150, "img/bg.png" )
		dxDrawImage( x + ( 150 - 81 ) / 2, y + ( 150 - 83 ) / 2 - gap_to_icon[ i ], 81, 77, "img/icon.png" )

		if gap_to_icon[ i ] > 13 then
			dxDrawText( "Its text", x, y + 75, x+150, y+150, tocolor( 0, 0, 0, 255 * progress ), 2, "default-bold", "center", "center" )
		end

		if update_interval and gap_to_icon[ i ] > 0 then
			local size_progress = 50 * progress + 125
			dxDrawImage( x + math.floor( 150 - size_progress ) / 2,
			 y + math.floor( 150 - size_progress ) / 2, size_progress, size_progress, "img/elipse.png", 0, 0, 0, tocolor( 0, 0, 0 ) )
		end

		if isMouseInPosition( x, y, 150, 150 ) then
			if lastTick < currTick and not update_interval then
				lastTick = getTickCount( )
				update_interval = true
			end
			gap_to_icon[ i ] = gap_to_icon[ i ] + 1
			if gap_to_icon[ i ] > 15 then
				gap_to_icon[ i ] = 15
			end
		else
			if gap_to_icon[ i ] > 0 then
				gap_to_icon[ i ] = gap_to_icon[ i ] - 1
				update_interval = false
				progress = 0
			end
		end
	end
end)

function math.clamp(min, x, max)
    return math.max( math.min( x, max ), min );
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end