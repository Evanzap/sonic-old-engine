function love.load()
	sti=require 'sti'
	wf=require 'windfield'
	world= wf.newWorld(0,0)
	map=sti('maps/phystest.lua')
	player = {}
	player.collider= world:newBSGRectangleCollider(0,0,17,33,14)
	player.collider:setFixedRotation(true)
	player.x = 0
	player.y = 0
	player.speed=1
	player.vx=0
	player.vy=1
	air_acceleration_speed= 0.09375
	gravity_force= 0.21875
	acceleration_speed= 0.046875
 	deceleration_speed= 0.5
	friction_speed= 0.046875
	top_speed= 6
	love.window.setMode( 424, 424, flags )
	walls = {}
	if map.layers["Object Layer 1"] then
			for i, obj in pairs(map.layers["Object Layer 1"].objects) do
				local wall=world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height)
				wall:setType('static')
				table.insert(walls,wall)
			end
	end
end


function love.update(dt)
	player.x = player.collider:getX()
	player.y = player.collider:getY()
	if player.vy>16 then 
		player.vy=16
	end
	if player.vy < 0 and player.vy > -4 then
    	player.vx = player.vx - (player.vx/0.125) / 256
	end
	right= love.keyboard.isDown("right")
	left= love.keyboard.isDown("left")
	if left then
		player.vx=player.vx-acceleration_speed
	end
	if right then
		player.vx=player.vx+acceleration_speed
	end
	player.collider:setLinearVelocity(player.vx*50, player.vy*50)
	world:update(dt)
end

function love.draw()
	map:draw()
	love.graphics.scale( 1, 1 )
	love.graphics.rectangle("fill", player.x-8,player.y-16,17,33)
	world:draw()
end