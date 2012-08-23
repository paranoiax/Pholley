require "TEsound"
require "objects"
require "globals"
require "functions"

HC = require 'hardoncollider'

function love.load()	

	load_settings()
	load_objects()
	load_variables()
	
end

function love.update(dt)

	TEsound.cleanup()
	world:update(dt)
	start_game()
	increase_score()
	start_round1(dt)
	start_round2(dt)
	game_over_sound()
	match_ball_sound()
	player2_ai()
	controls()
	hardon_move()
	Collider:update(dt)
	
end

function love.draw()

	love.graphics.setColor(255,255,255)
	love.graphics.draw(backgroundImage, 0, 0)
	
	draw_winner()
	draw_matchball()	
	
	love.graphics.setFont(font)
	love.graphics.print(objects.player1.score, 20,15)
	love.graphics.print(objects.player2.score, screenWidth -45,15)
	--love.graphics.print(winner, screenWidth / 2,15)

	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(meshImage, objects.mesh.body:getX() - 4, screenHeight - 240)
	--love.graphics.polygon("fill", objects.mesh.body:getWorldPoints(objects.mesh.shape:getPoints()))
	--love.graphics.polygon("fill", objects.seperator.body:getWorldPoints(objects.seperator.shape:getPoints()))
	--love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	--love.graphics.polygon("fill", objects.leftWall.body:getWorldPoints(objects.leftWall.shape:getPoints()))
	--love.graphics.polygon("fill", objects.rightWall.body:getWorldPoints(objects.rightWall.shape:getPoints()))
	--love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints()))
	
	love.graphics.setColor(255,255,255)
	love.graphics.draw(playerShadow, objects.player1.body:getX() - 31, screenHeight - 32)
	love.graphics.draw(playerShadow, objects.player2.body:getX() - 31, screenHeight - 32)
	love.graphics.draw(ballShadow, objects.ball.body:getX() - 23, screenHeight - 30)	
	love.graphics.draw(objects.ball.image, objects.ball.body:getX() - 22, objects.ball.body:getY() - 22)
	love.graphics.draw(playerImage, objects.player1.body:getX() - 33, objects.player1.body:getY() - 33)
	love.graphics.draw(playerImage, objects.player2.body:getX() - 33, objects.player2.body:getY() - 33)
	
	draw_countdown()
	
	--love.graphics.setColor(255,50,230)
	--love.graphics.circle("line", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius(), 30)
	
	--love.graphics.setColor(0,125,255)
	--love.graphics.circle("line", objects.player1.body:getX(), objects.player1.body:getY(), objects.player1.shape:getRadius(), 30)
	--love.graphics.circle("line", objects.player2.body:getX(), objects.player2.body:getY(), objects.player2.shape:getRadius(), 30)

end