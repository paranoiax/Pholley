function player2_ai(dt)
	if objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getX() +18 < objects.player2.body:getX() then
		objects.player2.body:applyForce(-2000, 0)--2300
	elseif objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getX() +18 > objects.player2.body:getX() and objects.ball.body:getX() < screenWidth - 81 then
		objects.player2.body:applyForce(2000, 0)--2300
	end
	if objects.ball.body:getX() > screenWidth / 2 and objects.ball.body:getY() > screenHeight - screenHeight / 3 and objects.player2.body:getY() > objects.ball.body:getY() and objects.ball.body:getX() - 40 < objects.player2.body:getX() and objects.ball.body:getX() + 40 > objects.player2.body:getX() and objects.player2.body:getY() > screenHeight - 55 then
		objects.player2.body:applyLinearImpulse(0, -1300)
		TEsound.playLooping(jumpSound, "sfx", 1)
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
		love.graphics.printf("Player 1 wins!", screenWidth / 4, screenHeight / 3 - 15, screenWidth / 2, 'center')
		love.graphics.printf("Press 'R' to restart!", screenWidth / 4, screenHeight / 3 + 25, screenWidth / 2, 'center')
		objects.ball.body:setActive(false)
		objects.player1.body:setActive(false)
		objects.player2.body:setActive(false)
		begin_player_1 = false
		begin_player_2 = false
		winner = 1
	elseif objects.player2.score >= maxpoints and objects.player2.score - objects.player1.score >= 2 then		
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 2 wins!", screenWidth / 4, screenHeight / 3 - 15, screenWidth / 2, 'center')
		love.graphics.printf("Press 'R' to restart!", screenWidth / 4, screenHeight / 3 + 25, screenWidth / 2, 'center')
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
		love.graphics.printf("Player 1 MATCHBALL!", screenWidth / 4, screenHeight / 3 -15, screenWidth / 2, 'center')
	elseif objects.player2.score >= maxpoints -1 and objects.player2.score - objects.player1.score >= 1 and winner == 0 then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font2)
		love.graphics.printf("Player 2 MATCHBALL!", screenWidth / 4, screenHeight / 3 -15, screenWidth / 2, 'center')
	end
end

function controls()
	function love.keypressed(key)
		if objects.player1.body:getY() > screenHeight - 55 and key == "w" and winner == 0 and remainingTime == 3 then
			objects.player1.body:applyLinearImpulse(0, -1300)
			TEsound.playLooping(jumpSound, "sfx", 1)
		elseif key == "r" and winner == 1 then		
			begin_player_1 = false
			begin_player_2 = false
			objects.player1.score = 0
			objects.player2.score = 0
			objects.ball.body:setActive(true)
			objects.player1.body:setActive(true)
			objects.player2.body:setActive(true)
			objects.player1.body:setLinearVelocity(0,0)
			objects.player2.body:setLinearVelocity(0,0)
			winner = 0
			gameOverSoundPlayed = false
		end
	end
		
	if love.keyboard.isDown("a") then
		objects.player1.body:applyForce(-3300, 0)
	elseif love.keyboard.isDown("d") then
		objects.player1.body:applyForce(3300, 0)
	end
end

function start_game()
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
	elseif begin_player_2 == true and winner == 0 then
		objects.ball.body:applyLinearImpulse(-64, 0)
		begin_player_2 = false
	end
end

function increase_score()
	if objects.ball.body:getY() > screenHeight - 40 then
		if objects.ball.body:getX() > screenWidth / 2 then
			objects.player1.score = objects.player1.score + 1
			TEsound.playLooping(hitSound, "sfx", 1)
			if objects.player1.score >= maxpoints and objects.player1.score - objects.player2.score >= 2 then 
				startgame = true
			else
				startRound1 = true 
			end
		elseif objects.ball.body:getX() < screenWidth / 2 then
			objects.player2.score = objects.player2.score + 1
			TEsound.playLooping(missSound, "sfx", 1)			
			if objects.player2.score >= maxpoints and objects.player2.score - objects.player1.score >= 2 then 
				startgame = true
			else
				startRound2 = true 
			end			
		end
	end
end

function game_over_sound()	
	if winner == 1 and gameOverSoundPlayed == false then		
		TEsound.playLooping(gameOverSound, "sfx", 1)
		gameOverSoundPlayed = true
	end
end

function match_ball_sound()
	if objects.player1.score >= maxpoints -1 and objects.player1.score - objects.player2.score >= 1 and winner == 0 then
		matchballActive = true
	elseif objects.player2.score >= maxpoints -1 and objects.player2.score - objects.player1.score >= 1 and winner == 0 then
		matchballActive = true
	else
		matchballActive = false
		matchBallSoundPlayed = false
	end
	
	if matchballActive == true and matchBallSoundPlayed == false then
		TEsound.playLooping(matchBallSound, "sfx", 1)
		matchBallSoundPlayed = true
	end
end

function start_round1(dt)
	if startRound1 == true then
		startgame = true
		remainingTime = remainingTime - dt * 1.5
	end
	if remainingTime <= 1 then		
		startRound1 = false
		begin_player_1 = true
		remainingTime = 3
	end
end

function start_round2(dt)
	if startRound2 == true then
		startgame = true
		remainingTime = remainingTime - dt * 1.5
	end
	if remainingTime <= 1 then
		startRound2 = false
		begin_player_2 = true
		remainingTime = 3
	end
end

function draw_countdown()
	if startRound1 == true or startRound2 == true then
		if winner == 0 then
			love.graphics.setFont(font)
			love.graphics.print(math.floor(remainingTime + .5), objects.ball.body:getX() - 6, objects.ball.body:getY() - 13)
		end
	end
end

function get_AI_Velocity()
		AIx, AIy = objects.player2.body:getLinearVelocity()
end
	
function draw_player1()
	if love.keyboard.isDown("d") and objects.player1.body:getY() > screenHeight  -50 then
		anim:play()
		anim:draw(objects.player1.body:getX() - 32, objects.player1.body:getY() - 32)
	elseif love.keyboard.isDown("a") and objects.player1.body:getY() > screenHeight  -50 then
		anim:play()
		anim:draw(objects.player1.body:getX() - 32, objects.player1.body:getY() - 32)
	elseif objects.player1.body:getY() < screenHeight  -50 then
		anim:seek(1)
		anim:stop()
		anim:draw(objects.player1.body:getX() - 32, objects.player1.body:getY() - 32)
	else
		anim:seek(2)
		anim:stop()
		anim:draw(objects.player1.body:getX() - 32, objects.player1.body:getY() - 32)
	end
end

function draw_AI()
	if AIx < 0 or AIx > 0 and objects.player2.body:getY() > screenHeight -50 then
		anim2:play()
		anim2:draw(objects.player2.body:getX() - 32, objects.player2.body:getY() - 32)
	elseif objects.player2.body:getY() < screenHeight - 50 then
		anim2:seek(2)
		anim2:stop()
		anim2:draw(objects.player2.body:getX() - 32, objects.player2.body:getY() - 32)
	else
		anim2:seek(1)
		anim2:stop()
		anim2:draw(objects.player2.body:getX() - 32, objects.player2.body:getY() - 32)
	end
end

function beginCallback(fixture1, fixture2, contact)
	
	if fixture1:getUserData() == "ball" or fixture2:getUserData() == "ball" then
		if fixture1:getUserData() == "player" or fixture2:getUserData() == "player" then
			TEsound.playLooping(collisionSound, "sfx", 1)
		end
	end
	
end