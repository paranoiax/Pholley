function load_objects()
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
	objects.mesh.shape = love.physics.newRectangleShape(4, screenHeight / 3 - 10)
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
	objects.ball.body:setAngularDamping(1.5)
	
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
end