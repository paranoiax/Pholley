require "TEsound"
require "AnAL"
require "objects"
require "globals"
require "functions"

function love.load()	

	load_settings()
	load_objects()
	load_variables()
	
	min_dt = 1/60
	next_time = love.timer.getMicroTime()
	
end

function love.update(dt)

	next_time = next_time + min_dt
	
	TEsound.cleanup()
	world:update(dt)
	start_game()
	increase_score()
	start_round1(dt)
	start_round2(dt)
	game_over_sound()
	match_ball_sound()
	player2_ai(dt)
	controls()
	anim:update(dt)
	anim2:update(dt)
	get_AI_Velocity()
	
end

function love.draw()

	love.graphics.setColor(255,255,255)
	love.graphics.draw(backgroundImage, 0, 0)
	
	draw_winner()
	draw_matchball()	
	
	love.graphics.setFont(font3)
	love.graphics.printf(objects.player1.score, 25,15, 100, "left")
	love.graphics.printf(objects.player2.score, screenWidth -125,15,100,"right")

	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(meshImage, objects.mesh.body:getX() - 4, screenHeight - 240)
	
	love.graphics.setColor(255,255,255)
	love.graphics.draw(playerShadow, objects.player1.body:getX() - 27, screenHeight - 32)
	love.graphics.draw(playerShadow, objects.player2.body:getX() - 31, screenHeight - 32)
	love.graphics.draw(ballShadow, objects.ball.body:getX() - 23, screenHeight - 30)	
	love.graphics.draw(objects.ball.image, objects.ball.body:getX() - 22, objects.ball.body:getY() - 22)

	draw_player1()
	draw_countdown()
	draw_AI()
	
	local cur_time = love.timer.getMicroTime()
		if next_time <= cur_time then
			next_time = cur_time
		return
	end
	love.timer.sleep(1*(next_time - cur_time))

end