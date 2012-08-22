function load_settings()
	font = love.graphics.newFont(22)
	font2 = love.graphics.newFont(36)

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
	
end