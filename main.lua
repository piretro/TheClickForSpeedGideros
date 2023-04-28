--Piretro Software The Click For Speed 2023 Pietro Eccher - pure gideros lua mini game - based on The Click For Speed mobile game by Nicola Danese
application:setBackgroundColor(0x000)
function getRdnCol()
	local color_digits = {0,1,2,3,4,5,6,7,8,9}
	local out =""
	for i =1, 6 do 
		out = out..color_digits[math.random(#color_digits)]
	end
	return out
end
	
tx = "\e[color=#FFF]Click on the WHITE SQUARE ASAP!"
nf = TextField.new(nil, tx.."\e[color]")
nf:setScale(3)
nf:setPosition(440, 40)
stage:addChild(nf)
px = {}
function newGame()
	f = false
	i = 0
	for r=1, 20 do 
		for c=1,20 do
			i= i+1
			px[i]= Pixel.new("0x"..getRdnCol(), 1, 20,20)
			px[i]:setPosition(20*r,20*c)
			stage:addChild(px[i])
		end
	end
	st_time, n_time, w_time, ck_time, s  = os.time(), math.random(7), "", "", math.random(#px)
end

st_time, n_time, s  = os.time(), math.random(7), 1
newGame()
stage:addEventListener(Event.MOUSE_DOWN, function(e)
										if px[s]:hitTestPoint(e.x, e.y) then
											ck_time = os.timer() - w_time
											nf:setText(tx.."\nClicked in "..ck_time.." seconds\nRETRY\e[color]")
											f = true
										end
										if f == true and nf:hitTestPoint(e.x, e.y) then
											nf:setText(tx.."\e[color]")
											newGame()
										end
									end)
stage:addEventListener(Event.ENTER_FRAME, function()	
										if px[s] and px[s]:getColor()~=0xFFFFFF and os.time() - st_time > n_time then
											px[s]:setColor(0xFFFFFF)
											w_time = os.timer()
										end
									end)