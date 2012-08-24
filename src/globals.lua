function load_settings()
	font = love.graphics.newFont(22)
	font2 = love.graphics.newFont(36)
	font3 = love.graphics.newFont(48)

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81 * 64, true)
	
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end

function load_variables()
	gameOverSoundPlayed = false
	
	matchballActive = false
	matchBallSoundPlayed = false
	startgame = true
	winner = 0
	maxpoints = 5
	
	Collider = HC(100, on_collide)
	hardon_ball = Collider:addCircle(objects.ball.body:getX(), objects.ball.body:getY(), 20)
	hardon_player1 = Collider:addCircle(objects.player1.body:getX(), objects.player1.body:getY(), 28)
	hardon_player2 = Collider:addCircle(objects.player2.body:getX(), objects.player2.body:getY(), 28)
	
	remainingTime = 3
	roundStart1 = false
	roundStart2 = false
	
	playerImage = love.graphics.newImage('sprites/player.png')
	backgroundImage = love.graphics.newImage("sprites/bg.png")
	playerShadow = love.graphics.newImage("sprites/player_shadow.png")
	ballShadow = love.graphics.newImage("sprites/ball_shadow.png")
	meshImage = love.graphics.newImage("sprites/mesh.png")
	
	jumpSound = "sounds/jump.wav"
	hitSound =  "sounds/hit.wav"
	missSound =  "sounds/miss.wav"
	gameOverSound = "sounds/game_over.wav"
	matchBallSound = "sounds/matchball.wav"
	collisionSound = "sounds/collision.wav"	
	
	local player1AnimImg = love.graphics.newImage("sprites/bunny.png")
	local player2AnimImg = love.graphics.newImage("sprites/bunny_2.png")
	
	anim = newAnimation(player1AnimImg, 64, 64, 0.075, 0)
	anim2 = newAnimation(player2AnimImg, 64, 64, 0.075, 0)
	
end