lg = love.graphics

function ShowMsg(m,x,y)
	lg.print(m, positionText.x+x, positionText.y+y)
end

function ShowWin(m,x,y)
	lg.print('Victorias: ' .. win, positionText.x+x, positionText.y+y)
end

function ShowPkm(m,x,y)
	lg.print(playerPk.name, positionText.x+x, positionText.y+y)
end

function GenerateAttack()
	if playerPk.attack == false then
		cube.y = playerPk.y + 30
		cube.x = playerPk.x + 30
		playerPk.attack = true
	end
end

function AttackMoved(dt)
	if playerPk.attack == true then
		cube.x = cube.x + 3
		if cube.x > 770 then
			cube.x = null
			cube.y = null
			playerPk.attack = false
			disAtt = false
		end
	end
end

function BotAutomatic(pk, dt)
	time = love.timer.getTime()

	if time % 1 > 0 and time % 1 < 0.1 then
		mov = math.random(1,4)
		
	end

	if mov == 1 and pk.y > 130 then
		pk.y = pk.y - pk.vel
		
	elseif mov == 2 and pk.y < 490 then
		pk.y = pk.y + pk.vel
	
	elseif mov == 3 and pk.x < 700 then
		pk.x = pk.x + pk.vel
	
	elseif mov == 4 and pk.x > 440 then
		pk.x = pk.x - pk.vel
	end
end

function BotAttack()
	time = love.timer.getTime()

	if time % 2 > 0.1 and time % 2 < 0.3 then
		enemy.y = bot[pkmLimit][pkmRandom].y + 10
		enemy.x = bot[pkmLimit][pkmRandom].x - 10
		bot[pkmLimit][pkmRandom].attack = true
	end
end

function AttackMovedBot(dt)
	if bot[pkmLimit][pkmRandom].attack == true then
		enemy.x = enemy.x - bot[pkmLimit][pkmRandom].vel 
		if enemy.x < 30 then
			enemy.x = null
			enemy.y = null
			bot[pkmLimit][pkmRandom].attack = false
			disAtt = false
			rango = false
		end
	end
end

function GetLimit(w)
	if w >= 0 and w < 11 then
		pkmLimit = 1
		pkmRandom = math.random(1,10)
	elseif w > 10 and w < 19 then
		pkmLimit = 2
		pkmRandom = math.random(1,8)
	elseif w > 18 and w < 31 then
		pkmLimit = 3
		pkmRandom = math.random(1,7)
	elseif w > 30 then
		pkmLimit = 4
		pkmRandom = math.random(1,5)
		mega = true
	end
end

function CollicionAttackAttack()
	if playerPk.attack == true and bot[pkmLimit][pkmRandom].attack == true then
		getY = cube.y
		getX = cube.x
		if getY > enemy.y-20 and getY < enemy.y+20+20 then
			disAtt = true
			rango = false
		end
	end
end

function DistroyAttack(distroy)
	bot[pkmLimit][pkmRandom].attack = false
	playerPk.attack = false
	getX = null
	getY = null
	disAtt = false
	rango = false
end

function CollicionAttackBot()
	if bot[pkmLimit][pkmRandom].y < cube.y and
		bot[pkmLimit][pkmRandom].y+25+50 > cube.y then
			if bot[pkmLimit][pkmRandom].x < cube.x+cube.w then
				bot[pkmLimit][pkmRandom].healt = bot[pkmLimit][pkmRandom].healt - playerPk.at
				DistroyAttack()
				if bot[pkmLimit][pkmRandom].healt < 0 then
					Victory()
				end
			end
	end
end

function CollicionAttack()
	if playerPk.y and enemy.y then
		if playerPk.y < enemy.y and
			playerPk.y+25+50 > enemy.y and 
			playerPk.x+50 > enemy.x and
			playerPk.x < enemy.x+enemy.w then
				DistroyAttack()
				playerPk.healt = playerPk.healt - bot[pkmLimit][pkmRandom].at
				if playerPk.healt < 1 then
					GameOver()
				end
		end
	end
end

function GameOver()
	goGame = false
	die = true
end

function AsigPkm(ip)
	playerPk.id = dataInicial[ip].id
	playerPk.name = dataInicial[ip].name
	playerPk.at = dataInicial[ip].at
	playerPk.healt = dataInicial[ip].healt
	playerPk.def = dataInicial[ip].def
	playerPk.vel = dataInicial[ip].vel
	playerPk.ev = dataInicial[ip].ev
	playerPk.url = dataInicial[ip].url
	playerPk.urlAttack = dataInicial[ip].urlAttack

	player = ip

	positionText.x = 50
	positionText.y = 15

	goGame = true
	msg = 'wasd: para moverse'
end

function Evolucion()
	if win > 5 and win < 8 then
		if player == 1 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 2

		elseif player == 4 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 2

		elseif player == 7 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 3
		end
			
	elseif win > 7 and win < 12 then
		if player == 2 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 4

		elseif player == 5 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 3

		elseif player == 8 then
			player = player + 1
			AsigPkm(player)
			pkmLimit = 3
		end

	elseif win > 11 then
		pkmLimit = 4

	end
end

function Victory()
	win = win + 1
	Evolucion()

	pkmRandom = pkmRandom + 1
	if pkmLimit == 1 then
		if pkmRandom > 9 then
			pkmRandom = 1
		end

	elseif pkmLimit == 2 then
		if pkmRandom > 8 then
			pkmRandom = 1
		end

	elseif pkmLimit == 3 then
		if pkmRandom > 7 then
			pkmRandom = 1
		end 

	elseif pkmLimit == 4 then
		if pkmRandom > 6 then
			pkmRandom = 1
		end 
	end
end

function Winner()
	goGame = false
	winner = true
end

function NewMusic(play)
	love.audio.pause()
	love.audio.play(play)
end

function love.load()
	-- Generate random
	backRand = 1
	cube = {x = 0, y = 0, w = 40, h = 20, color = {r=0,g=0,b=0}}
	enemy = {x = null, y = null, w = 40, h = 20, color = {r=0,g=0,b=0}}

	-- palet colors
	rgb = {
		r = {r = 1,g = 0,b = 0},
		b = {r = 0,g = 0,b = 1},
		g = {r = 0,g = 1,b = 0},
		p = {r = 0.5,g = 0,b = 0.7},
		y = {r = 1,g = 1,b = 0},
		gr = {r = 0.3,g = 0.3,b = 0.5},
		ma = {r=0.7,g=0.7,b=0}
	}

	-- Variable logic game
	goGame = false
	gamer = false
	disAtt = false
	distroy = {x=0, y=0}
	mov = math.random(1,4)
	time = 0
	at = {x=0,y=0}
	win = 0
	pkmLimit = 0
	pkmRandom = 0
	getY = 0
	getX = 0
	dateTime = 0
	die = false
	winner = false
	mega = false

	-- INSTANCES
	GetLimit(win)

	-- text direction
	mold = lg.newImage('assets/back/model.png')
	dieBackground = 'assets/back/die.png'
	positionText = {x = 110, y = 40}
	winnerUrl = 'assets/back/winner.png'

	-- Player
	player = 0
	playerPk = {
		url = null, --lg.newImage('assets/pkmn/4.png'),
		urlAttack = null,
		id = null,
		name = null,
		at = null,
		def = null,
		vel = null,
		ev = null,
		healt = null,
		x = 60,
		y = 330,
		attack = false,
		col = {r=0,g=0,b=0}
	}

	dataInicial = {
		{
			url = 'assets/pkmn/1.png',
			id = 1,
			urlAttack = 'assets/attacks/hoja-r.png',
			name = 'Bulbasaur',
			at = 15,
			def = 18,
			vel = 3,
			ev = true,
			healt = 25,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.g
		},{
			url = 'assets/pkmn/2.png',
			id = 2,
			name = 'Ivisaur',
			urlAttack = 'assets/attacks/hoja-r.png',
			at = 30,
			def = 40,
			vel = 5,
			ev = true,
			healt = 50,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.g
		},{
			url = 'assets/pkmn/3.png',
			id = 3,
			urlAttack = 'assets/attacks/hoja-r.png',
			name = 'Venusaur',
			at = 50,
			def = 65,
			vel = 15,
			ev = false,
			healt = 80,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.g
		},{
			url = 'assets/pkmn/4.png',
			id = 4,
			urlAttack = 'assets/attacks/fire-r.png',
			name = 'Charmander',
			at = 20,
			def = 15,
			vel = 8,
			ev = true,
			healt = 20,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.r
		},{
			url = 'assets/pkmn/5.png',
			id = 5,
			urlAttack = 'assets/attacks/fire-r.png',
			name = 'Charmeleon',
			at = 35,
			def = 30,
			vel = 12,
			ev = true,
			healt = 55,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.r
		},{
			url = 'assets/pkmn/6.png',
			id = 6,
			urlAttack = 'assets/attacks/fire-r.png',
			name = 'Charizard',
			at = 90,
			def = 80,
			vel = 18,
			ev = false,
			healt = 120,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.r
		},{
			url = 'assets/pkmn/7.png',
			id = 1,
			urlAttack = 'assets/attacks/water-r.png',
			name = 'Squirtle',
			at = 12,
			def = 25,
			vel = 8,
			ev = true,
			healt = 30,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.b
		},{
			url = 'assets/pkmn/8.png',
			id = 2,
			urlAttack = 'assets/attacks/water-r.png',
			name = 'Wartortle',
			at = 25,
			def = 40,
			vel = 12,
			ev = true,
			healt = 50,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.b
		},{
			url = 'assets/pkmn/9.png',
			id = 3,
			urlAttack = 'assets/attacks/water-r.png',
			name = 'Blastoise',
			at = 60,
			def = 80,
			vel = 15,
			ev = false,
			healt = 130,
			x = 60,
			y = 330,
			attack = false,
			col = rgb.b
		}
	}

	bot = {
		-- LEVEL 1
		{
			{
				url ='assets/pkmn/10.png',
				id = 10,
				urlAttack = 'assets/attacks/thunder-l.png',
				name = 'Pikachu',
				at = 5,
				vel = 2,
				healt = 25,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.y
			},{
				url ='assets/pkmn/11.png',
				id = 11,
				urlAttack = 'assets/attacks/hoja-l.png',
				name = 'Oddish',
				at = 7,
				vel = 3,
				healt = 28,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.g
			},{
				url ='assets/pkmn/12.png',
				id = 12,
				urlAttack = 'assets/attacks/veneno-l.png',
				name = 'Kofing',
				at = 6,
				vel = 2,
				healt = 30,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/13.png',
				id = 13,
				urlAttack = 'assets/attacks/fire-l.png',
				name = 'Growlithe',
				at = 8,
				vel = 2,
				healt = 25,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			},{
				url ='assets/pkmn/14.png',
				id = 14,
				urlAttack = 'assets/attacks/water-l.png',
				name = 'Poliwid',
				at = 6,
				vel = 2,
				healt = 20,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.b
			},{
				url ='assets/pkmn/15.png',
				id = 15,
				urlAttack = 'assets/attacks/psyqui-l.png',
				name = 'Abra',
				at = 5,
				vel = 3,
				healt = 30,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.ma
			},{
				url ='assets/pkmn/16.png',
				id = 16,
				urlAttack = 'assets/attacks/rock-l.png',
				name = 'Geodude',
				at = 6,
				vel = 2,
				healt = 25,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.ma
			},{
				url ='assets/pkmn/17.png',
				id = 17,
				urlAttack = 'assets/attacks/veneno-l.png',
				name = 'Grimer',
				at = 6,
				vel = 3,
				healt = 25,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/18.png',
				id = 18,
				urlAttack = 'assets/attacks/veneno-l.png',
				name = 'Gastly',
				at = 7,
				vel = 4,
				healt = 28,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/19.png',
				id = 19,
				urlAttack = 'assets/attacks/water-l.png',
				name = 'Horsea',
				at = 6,
				vel = 3,
				healt = 20,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.gr
			}
		},
		-- LEVEL 2
		{
			{
				url ='assets/pkmn/20.png',
				id = 20,
				urlAttack = 'assets/attacks/water-l.png',
				name = 'Poliwar',
				at = 9,
				vel = 4,
				ev = false,
				healt = 40,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.b
			},{
				url ='assets/pkmn/21.png',
				id = 21,
				urlAttack = 'assets/attacks/psyqui-l.png',
				name = 'Kadabra',
				at = 10,
				vel = 5,
				ev = false,
				healt = 60,
				x = 700,
				y = 400,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/22.png',
				id = 22,
				urlAttack = 'assets/attacks/rock-l.png',
				name = 'Graveler',
				at = 10,
				vel = 3,
				ev = false,
				healt = 50,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.ma
			},{
				url ='assets/pkmn/23.png',
				id = 23,
				urlAttack = 'assets/attacks/veneno-l.png',
				name = 'Haunter',
				at = 10,
				vel = 5,
				ev = false,
				healt = 55,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/24.png',
				id = 24,
				urlAttack = 'assets/attacks/rock-l.png',
				name = 'Ryhorn',
				at = 12,
				vel = 4,
				ev = false,
				healt = 60,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/25.png',
				id = 25,
				urlAttack = 'assets/attacks/water-l.png',
				name = 'Vaporeon',
				at = 9,
				vel = 2,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.b
			},{
				url ='assets/pkmn/26.png',
				id = 26,
				urlAttack = 'assets/attacks/thunder-l.png',
				name = 'Jolteon',
				at = 9,
				vel = 5,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.y
			},{
				url ='assets/pkmn/27.png',
				id = 27,
				urlAttack = 'assets/attacks/fire-l.png',
				name = 'Flareon',
				at = 9,
				def = 25,
				vel = 2,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			}
		},
		-- LEVEL 3
		{
			{
				url ='assets/pkmn/28.png',
				id = 28,
				urlAttack = 'assets/attacks/fire-l.png',
				name = 'Arcanine',
				at = 14,
				vel = 4,
				ev = false,
				healt = 80,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			},{
				url ='assets/pkmn/29.png',
				id = 29,
				urlAttack = 'assets/attacks/veneno-l.png',			
				name = 'Arbok',
				at = 12,
				vel = 3,
				ev = false,
				healt = 80,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/30.png',
				id = 30,
				urlAttack = 'assets/attacks/psyqui-l.png',		
				name = 'Alakazam',
				at = 15,
				vel = 5,
				ev = false,
				healt = 90,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url ='assets/pkmn/31.png',
				urlAttack = 'assets/attacks/rock-l.png',
				id = 31,
				name = 'Tauros',
				at = 14,
				vel = 4,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.gr
			},{
				url ='assets/pkmn/32.png',
				id = 32,
				urlAttack = 'assets/attacks/rock-l.png',		
				name = 'Golem',
				at = 18,
				vel = 3,
				ev = false,
				healt = 80,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.ma
			},{
				url ='assets/pkmn/33.png',
				id = 33,
				urlAttack = 'assets/attacks/thunder-l.png',	
				name = 'Electabuzz',
				at = 18,
				vel = 3,
				ev = false,
				healt = 75,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.y
			},{
				url ='assets/pkmn/34.png',
				id = 34,
				urlAttack = 'assets/attacks/fire-l.png',				
				name = 'Magmar',
				at = 18,
				def = 45,
				vel = 3,
				ev = false,
				healt = 75,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			}
		},
		-- LEVEL 4
		{
			{
				url = 'assets/pkmn/35.png',
				id = 35,
				urlAttack = 'assets/attacks/psyqui-l.png',
				name = 'Mewtow',
				at = 30,
				vel = 5,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.p
			},{
				url = 'assets/pkmn/36.png',
				id = 36,
				urlAttack = 'assets/attacks/rock-l.png',
				name = 'Snorlax',
				at = 20,
				vel = 3,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.gr
			},{
				url = 'assets/pkmn/37.png',
				id = 46,
				urlAttack = 'assets/attacks/fire-l.png',
				name = 'Dragonite',
				at = 20,
				vel = 4,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			},{
				url = 'assets/pkmn/38.png',
				id = 46,
				urlAttack = 'assets/attacks/fire-l.png',
				name = 'Moltres',
				at = 20,
				vel = 4,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.r
			},{
				url = 'assets/pkmn/39.png',
				id = 46,
				urlAttack = 'assets/attacks/ice-l.png',				
				name = 'Articuno',
				at = 20,
				vel = 4,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.b
			},{
				url = 'assets/pkmn/40.png',
				id = 46,
				urlAttack = 'assets/attacks/thunder-l.png',
				name = 'Zapdos',
				at = 20,
				vel = 4,
				ev = false,
				healt = 120,
				x = 700,
				y = 350,
				attack = false,
				col = rgb.y
			}
		}
	}

	-- backgrounds
	backgrounds = {
		lg.newImage('assets/back/back.png'),
		lg.newImage('assets/back/1.png'),
		lg.newImage('assets/back/2.png')
	}

	-- Tipographis
	fonts = {
		die = 'assets/font/die.png', 
		winner = 'assets/font/winner.png',
		selec = 'assets/font/select.png'
	}

	-- Sounds
	sounds = {
		start = love.audio.newSource('assets/sound/start.mp3', 'static'),
		batle = love.audio.newSource('assets/sound/batle.mp3', 'static'),
		winner = love.audio.newSource('assets/sound/winner.mp3', 'static'),
		die = 'null'
	}

	-- Huevos
	huevos = {
		lg.newImage('assets/huevo/1.png'),
		lg.newImage('assets/huevo/4.png'),
		lg.newImage('assets/huevo/7.png')
	}

	-- Get Window / Heigth background
	background = backgrounds[backRand]
	window = { w = lg.getWidth(), h = lg.getHeight() }

	backWidth = background:getWidth()
	backHeight = background:getHeight()
	backRand = math.random(2,3)
end

function love.update(dt)
	if goGame == true and die == false then
		if playerPk.attack == true then
			AttackMoved(dt)
		end

		BotAutomatic(bot[pkmLimit][pkmRandom], dt)
		if love.keyboard.isDown('w') and playerPk.y > 110 then
			playerPk.y = playerPk.y - playerPk.vel
		end

		if love.keyboard.isDown('s') and playerPk.y < 490 then
			playerPk.y = playerPk.y + playerPk.vel
		end

		if love.keyboard.isDown('d') and playerPk.x < 330 then
			playerPk.x = playerPk.x + playerPk.vel
		end

		if love.keyboard.isDown('a') and playerPk.x > 40 then
			playerPk.x = playerPk.x - playerPk.vel
		end

		if bot[pkmLimit][pkmRandom].attack == true then
			CollicionAttack()
		end

		if playerPk.attack == true then
			CollicionAttackBot()
		end

		if bot[pkmLimit][pkmRandom].name == 'Mewtow' then
			mega = true
		end
	end

	if goGame == false and die == false then
		NewMusic(sounds.batle)
	elseif goGame == true and die == false then
		NewMusic(sounds.start)
		
	elseif winner == true then
		NewMusic(sounds.winner)
	end
end

function love.draw()
	-- Generate Huevos
	if goGame == false then
		if die == true then
			lg.draw(lg.newImage(dieBackground),0,0,0, window.w/backWidth, window.h/backHeight)
			lg.draw(lg.newImage(fonts.die), 100, 50)
		elseif winner == true then
			lg.draw(lg.newImage(winnerUrl),0,0,0, window.w/backWidth, window.h/backHeight)
			lg.print(playerPk.name .. ' eres el ganador',playerPk.x-10,playerPk.y-5)
			lg.draw(lg.newImage(playerPk.url), 400-55,400-90)
			lg.draw(lg.newImage(fonts.winner), 100, 50)
			lg.draw(mold,0,500,0, window.w/backWidth, window.h/backHeight)
			lg.draw(mold,250,500,0, window.w/backWidth, window.h/backHeight)
			lg.draw(mold,500,500,0, window.w/backWidth, window.h/backHeight)
			
			lg.setColor(0,0,0)
			ShowMsg(msg,0,500)
			ShowWin(msg,250,500)
			ShowPkm(msg,500,500)
			lg.setColor(1,1,1)

			playerPk.x = 400 - 50
			playerPk.y = 300 - 30
			msg = 'Eres el ganador.'

		else
			lg.draw(background,0,0,0, window.w/backWidth, window.h/backHeight)
			lg.draw(lg.newImage(fonts.selec), 100, 90)
			lg.draw(huevos[2], 370,330)
			lg.draw(huevos[1], 170,330)
			lg.draw(huevos[3], 570,330)
			lg.setColor(0,1,0)
			lg.rectangle('fill', 150,400, 110,30)
			lg.setColor(1,0,0)
			lg.rectangle('fill', 350,400, 110,30)
			lg.setColor(0,0,1)
			lg.rectangle('fill', 550,400, 110,30)
		end

	elseif goGame == true and die == false then
		background = backgrounds[backRand]
		backWidth = background:getWidth()
		backHeight = background:getHeight()
		lg.draw(background,0,0,0, window.w/backWidth, window.h/backHeight)
		lg.draw(mold,0,0,0, window.w/backWidth, window.h/backHeight)
		lg.draw(mold,250,0,0, window.w/backWidth, window.h/backHeight)
		lg.draw(mold,500,0,0, window.w/backWidth, window.h/backHeight)

		lg.setColor(0,0,0)
		ShowMsg(msg,0,0)
		ShowWin(msg,250,0)
		ShowPkm(msg,500,0)
		lg.setColor(1,1,1)

		lg.print(playerPk.name .. ' - ' .. playerPk.healt, playerPk.x-10,playerPk.y-5)
		lg.draw(lg.newImage(playerPk.url) , playerPk.x,playerPk.y)


		lg.print(bot[pkmLimit][pkmRandom].name .. ' - ' .. bot[pkmLimit][pkmRandom].healt, bot[pkmLimit][pkmRandom].x-20,bot[pkmLimit][pkmRandom].y-15)
		lg.draw(lg.newImage(bot[pkmLimit][pkmRandom].url) , bot[pkmLimit][pkmRandom].x,bot[pkmLimit][pkmRandom].y)

		if love.keyboard.isDown('j') then
			if playerPk.attack == false then
				GenerateAttack()
			end
		end

		if playerPk.attack == true then
			AttackMoved(dateTime)
			if playerPk.attack == true then
				lg.draw(lg.newImage(playerPk.urlAttack),cube.x,cube.y)
				CollicionAttackAttack()
			end
		end

		if bot[pkmLimit][pkmRandom].attack == false then
			BotAttack()
		else 
			lg.draw(lg.newImage(bot[pkmLimit][pkmRandom].urlAttack), enemy.x,enemy.y)
			CollicionAttack()
			AttackMovedBot(dateTime)
		end

		if disAtt == true then
			if getX+40 > enemy.x then
				DistroyAttack()
			end
		end

		if mega == true then
			msg = 'k: Mega Evolucion'
			if love.keyboard.isDown('k') then
				if player == 3 then
					playerPk.url = 'assets/pkmn/m3.png'

				elseif player == 6 then
					playerPk.url = 'assets/pkmn/m6.png'

				elseif player == 9 then
					playerPk.url = 'assets/pkmn/m9.png'

				end
				bot[pkmLimit][pkmRandom].url = 'assets/pkmn/m35.png'
			end
		end

		if bot[4][1].healt < 1 then
			Winner()
		end
	end
	lg.setColor(1,1,1)
end

function love.keypressed(key)
	if goGame == true then
		if key == 'w' or key == 'a' or key == 's' or key == 'd' then
			gamer = true
		end
	end
end

function love.mousereleased(x,y,b)
	if y > 400 and y < 430 then
		if x > 150 and x < 260 then
			AsigPkm(1, rgb.g)			

		elseif x > 350 and x < 460 then
			AsigPkm(4,rgb.r)

		elseif x > 550 and x < 660 then
			AsigPkm(7, rgb.b)
			
		end
	end
end
