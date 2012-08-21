function love.load()

	font = love.graphics.newFont(22)
	font2 = love.graphics.newFont(36)

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)
	
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
	objects = {}
	
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, screenWidth / 2, screenHeight)
	objects.ground.shape = love.physics.newRectangleShape(screenWidth, 25)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)	
	objects.ground.fixture:setCategory(2)
	
	objects.leftWall = {}
	objects.leftWall.body = love.physics.newBody(world, 0, screenHeight / 2)
	objects.leftWall.shape = love.physics.newRectangleShape(25, screenHeight)
	objects.leftWall.fixture = love.physics.newFixture(objects.leftWall.body, objects.leftWall.shape)
	objects.leftWall.fixture:setCategory(2)
	
	objects.rightWall = {}
	objects.rightWall.body = love.physics.newBody(world, screenWidth, screenHeight / 2)
	objects.rightWall.shape = love.physics.newRectangleShape(25, screenHeight)
	objects.rightWall.fixture = love.physics.newFixture(objects.rightWall.body, objects.rightWall.shape)
	objects.rightWall.fixture:setCategory(2)
	
	objects.seperator = {}
	objects.seperator.body = love.physics.newBody(world, screenWidth / 2, screenHeight / 2)
	objects.seperator.shape = love.physics.newRectangleShape(2, screenHeight)
	objects.seperator.fixture = love.physics.newFixture(objects.seperator.body, objects.seperator.shape)
	objects.seperator.fixture:setCategory(1)
	objects.seperator.fixture:setMask(2)
	
	objects.mesh = {}
	objects.mesh.body = love.physics.newBody(world, screenWidth / 2, screenHeight - screenHeight / 6)
	objects.mesh.shape = love.physics.newRectangleShape(4, screenHeight / 3)
	objects.mesh.fixture = love.physics.newFixture(objects.mesh.body, objects.mesh.shape)
	objects.mesh.fixture:setCategory(2)
	
	objects.ceiling = {}
	objects.ceiling.body = love.physics.newBody(world, screenWidth / 2, 0)
	objects.ceiling.shape = love.physics.newRectangleShape(screenWidth, 25)
	objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape)
	objects.ceiling.fixture:setCategory(2)
	
	objects.ball = {}
	objects.ball.image = love.graphics.newImage('sprites/ball.png')
	objects.ball.body = love.physics.newBody(world, screenWidth / 2, screenHeight / 2 - 170, "dynamic")
	objects.ball.shape = love.physics.newCircleShape(20)
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
	objects.ball.fixture:setCategory(2)
	objects.ball.fixture:setMask(1)
	objects.ball.fixture:setRestitution(0.8)
	objects.ball.body:setMass(0.215)
	objects.ball.body:setGravityScale(2.0)
	objects.ball.body:setLinearDamping(1.5)
	
	objects.player1 = {}
	objects.player1.body = love.physics.newBody(world, screenWidth / 8 * 3, screenHeight - 50, "dynamic")
	objects.player1.shape = love.physics.newCircleShape(28)
	objects.player1.fixture = love.physics.newFixture(objects.player1.body, objects.player1.shape, 1)
	objects.player1.fixture:setCategory(3)
	objects.player1.body:setGravityScale(6.5)	
	objects.player1.fixture:setRestitution(0.2)
	objects.player1.body:setFixedRotation(true)
	objects.player1.body:setLinearDamping(4)
	
	objects.player2 = {}
	objects.player2.body = love.physics.newBody(world, screenWidth - screenWidth / 8 * 3, screenHeight - 50, "dynamic")
	objects.player2.shape = love.physics.newCircleShape(28)
	objects.player2.fixture = love.physics.newFixture(objects.player2.body, objects.player2.shape, 1)
	objects.player2.fixture:setCategory(3)
	objects.player2.body:setGravityScale(6.5)
	objects.player2.fixture:setRestitution(0.2)
	objects.player2.body:setFixedRotation(true)
	objects.player2.body:setLinearDamping(1.5)
	objects.player2.fixture:setFriction(1.15) -- AI ONLY
	
	objects.player1.score = 0
	objects.player2.score = 0
	
	objects.player1.canJumpAgain = 0
	objects.player2.canJumpAgain = 0	
	
	startgame = true
	winner = 0
	maxpoints = 10
	
	playerImage = love.graphics.newImage('sprites/player.png')
	
end

function love.update(dt)

	world:update(dt)
	
	if startgame == true then
		objects.ball.body:setPosition(screenWidth / 2, screenHeight / 2 - 170)		
		objects.ball.body:setAngularVelocity(0,0)
		objects.ball.body:setLinearVelocity(0,0)
		objects.player1.body:setLinearVelocity(0,0)
		objects.player2.body:setLinearVelocity(0,0)
		objects.player2.body:setPosition(screenWidth - screenWidth / 8 * 3, screenHeight - 50)
		objects.player1.body:setPosition(screenWidth / 8 * 3, screenHeight - 50)		
		--love.timer.sleep( 0.5 )
		startgame = false
	end
	
	if begin_player_1 == true then
		objects.ball.body:applyLinearImpulse(64, 0)
		begin_player_1 = false
	elseif begin_player_2 == true then
		objects.ball.body:applyLinearImpulse(-64, 0)
		begin_player_2 = false
	end
	
	if objects.player1.body:getY() < screenHeight - screenHeight / 3.25 then
		objects.player1.canJumpAgain = 1
	end
	
	if objects.player2.body:getY() < screenHeight - screenHeight / 3.25 then
		objects.player2.canJumpAgain = 1
	end

	increase_score()
	player2_ai()
	controls()

end

function love.draw()

	draw_winner()
	draw_matchball()
	
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(font)
	love.graphics.print(objects.player1.score, 20,15)
	love.graphics.print(objects.player2.score, screenWidth -45,15)
	--love.graphics.print(winner, screenWidth / 2,15)

	love.graphics.setColor(255,255,255)
	love.graphics.polygon("fill", objects.mesh.body:getWorldPoints(objects.mesh.shape:getPoints()))
	--love.graphics.polygon("fill", objects.seperator.body:getWorldPoints(objects.seperator.shape:getPoints()))
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	love.graphics.polygon("fill", objects.leftWall.body:getWorldPoints(objects.leftWall.shape:getPoints()))
	love.graphics.polygon("fill", objects.rightWall.body:getWorldPoints(objects.rightWall.shape:getPoints()))
	love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints()))
	
	love.graphics.setColor(255,255,255)
	love.graphics.draw(objects.ball.image, objects.ball.body:getX() - 22, objects.ball.body:getY() - 22)
	love.graphics.draw(playerImage, objects.player1.body:getX() - 33, objects.player1.body:getY() - 33)
	love.graphics.draw(playerImage, objects.player2.body:getX() - 33, objects.player2.body:getY() - 33)
	
	--love.graphics.setColor(255,50,230)
	--love.graphics.circle("line", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius(), 30)
	
	--love.graphics.setColor(0,125,255)
	--love.graphics.circle("line", objects.player1.body:getX(), objects.player1.body:getY(), objects.player1.shape:getRadius(), 30)
	--love.graphics.circle("line", objects.player2.body:getX(), objects.player2.body:getY(), objects.player2.shape:getRadius(), 30)

end

function player2_ai()
	if objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getX() +20 < objects.player2.body:getX() then
		objects.player2.body:applyForce(-2300, 0)
	elseif objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getX() +20 > objects.player2.body:getX() and objects.ball.body:getX() < screenWidth - 81 then
		objects.player2.body:applyForce(2300, 0)
	end
	if objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getY() > screenHeight - screenHeight / 3 and objects.player2.body:getY() > objects.ball.body:getY() and objects.ball.body:getX() - 50 < objects.player2.body:getX() and objects.ball.body:getX() + 50 > objects.player2.body:getX() then
		objects.player2.body:applyLinearImpulse(0, -210)
	elseif objects.ball.body:getX() < screenWidth / 2 - 40 and objects.player2.body:getX() < screenWidth / 4 * 3 - 50 then
		objects.player2.body:applyForce(1850, 0)
	elseif objects.ball.body:getX() < screenWidth / 2 - 40 and objects.player2.body:getX() > screenWidth / 4 * 3 + 50 then
		objects.player2.body:applyForce(-1850, 0)
	end
end

function draw_winner()
	if objects.player1.score >= maxpoints and objects.player1.score - objects.player2.score >= 2 then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 1 wins!", screenWidth / 4, screenHeight / 2, screenWidth / 2, 'center')
		love.graphics.printf("Press 'R' to restart!", screenWidth / 4, screenHeight / 2 + 40, screenWidth / 2, 'center')
		objects.ball.body:setActive(false)
		objects.player1.body:setActive(false)
		objects.player2.body:setActive(false)
		begin_player_1 = false
		begin_player_2 = false
		winner = 1
	elseif objects.player2.score >= maxpoints and objects.player2.score - objects.player1.score >= 2 then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 2 wins!", screenWidth / 4, screenHeight / 2, screenWidth / 2, 'center')
		love.graphics.printf("Press 'R' to restart!", screenWidth / 4, screenHeight / 2 + 40, screenWidth / 2, 'center')
		objects.ball.body:setActive(false)
		objects.player1.body:setActive(false)
		objects.player2.body:setActive(false)
		begin_player_1 = false
		begin_player_2 = false
		winner = 1
	end
end

function draw_matchball()
	if objects.player1.score >= maxpoints -1 and objects.player1.score - objects.player2.score >= 1 and winner == 0 then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 1 MATCHBALL!", screenWidth / 4, screenHeight / 4 -80, screenWidth / 2, 'center')
	elseif objects.player2.score >= maxpoints -1 and objects.player2.score - objects.player1.score >= 1 and winner == 0 then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 2 MATCHBALL!", screenWidth / 4, screenHeight / 4 -80, screenWidth / 2, 'center')
	end
end

function controls()
	function love.keypressed(key)
		if objects.player1.body:getY() > screenHeight - 55 and key == "w" then
			objects.player1.body:applyLinearImpulse(0, -1300)
		elseif objects.player1.canJumpAgain == 1 and key == "w" then
			objects.player1.body:applyLinearImpulse(0, -500)
			objects.player1.canJumpAgain = 0
		elseif key == "r" and winner == 1 then
			objects.player1.score = 0
			objects.player2.score = 0
			objects.ball.body:setActive(true)
			objects.player1.body:setActive(true)
			objects.player2.body:setActive(true)
			objects.player1.body:setLinearVelocity(0,0)
			objects.player2.body:setLinearVelocity(0,0)
			winner = 0
		end
	end
		
	if love.keyboard.isDown("a") then
		objects.player1.body:applyForce(-3300, 0)
	elseif love.keyboard.isDown("d") then
		objects.player1.body:applyForce(3300, 0)
	end
end

function increase_score()
		if objects.ball.body:getY() > screenHeight - 40 then
			if objects.ball.body:getX() > screenWidth / 2 then
				objects.player1.score = objects.player1.score + 1
				startgame = true
				begin_player_1 = true
			elseif objects.ball.body:getX() < screenWidth / 2 then
				objects.player2.score = objects.player2.score + 1
				startgame = true
				begin_player_2 = true
			end
		end
end