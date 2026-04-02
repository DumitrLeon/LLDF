extends State
class_name Movement

func Enter():
	pass


func Update(_delta: float):
	#controlla attacckk
	check_attack(player)
	
	#basic friction logic, friction più lenta se sprinti
	if Input.is_action_pressed("sprint"):
		if ((player.velocity.x < -0.2) and (player.dir == 1)) or ((player.velocity.x > 0.2) and (player.dir == -1)):
			player.velocity.x = move_toward(player.velocity.x, 0.0, player.friction*6 * _delta)
		else:
			player.velocity.x = move_toward(player.velocity.x, player.sprinting_speed * player.dir, player.friction/1.5 * _delta)
	else:
		if ((player.velocity.x < -0.2) and (player.dir == 1)) or ((player.velocity.x > 0.2) and (player.dir == -1)):
			player.velocity.x = move_toward(player.velocity.x, 0.0, player.friction*2 * _delta)
		else:
			player.velocity.x = move_toward(player.velocity.x, player.walking_speed * player.dir, player.friction * _delta)
	#damn sembra in casinato ma ha senso giuro (a bellini non piacerebbe)
	

func Physics_process(delta: float) -> void:
	pass

func check_slide(player, returning : bool = false):
	if player.abilità.get("slide"):
		if returning:
			return true
		
		if (Input.is_action_just_pressed("slide")) and (player.slide_timer.time_left == 0):
			player.slide_timer.start()
			Transitioned.emit(self, "Slide")

func check_floor(player):
	if player:
		if player.is_on_floor():
			player.jumps_made = 0
			return true
		else:
			return false

func check_jump(player, returning: bool = false):
	if returning:
		if ((player.jumps_made == 0) and not (player.abilità.get("double_jump"))) or ((player.abilità.get("double_jump")) and (player.jumps_made < player.max_jumps)):
			player.jumps_made += 1
			return true
	
	if Input.is_action_just_pressed("jump"):
		if ((player.jumps_made == 0) and not (player.abilità.get("double_jump"))) or ((player.abilità.get("double_jump")) and (player.jumps_made < player.max_jumps)):
			player.jumps_made += 1
			Transitioned.emit(self, "Jump")

func check_attack(player):
	if check_floor(player):
		if Input.is_action_just_pressed("First_button"):
			player.set_meta("attack", "basic")
			Transitioned.emit(self, "Combat")

func apply_gravity(player, delta):
	if not check_floor(player):
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y = 0
