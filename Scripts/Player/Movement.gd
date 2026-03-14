extends State
class_name Movement

func Enter():
	pass


func Update(_delta: float):
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

func check_slide():
	if ((Input.is_action_pressed("down")) and (Input.is_action_pressed("jump")) and (player.slide_timer.time_left == 0)) or ((Input.is_action_just_pressed("slide")) and (player.slide_timer.time_left == 0)):
		player.slide_timer.start()
		Transitioned.emit(self, "Slide")

func check_floor():
	if player.is_on_floor():
		return true
	else:
		return false

func check_jump():
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")

func apply_gravity():
	if not check_floor():
		player.velocity.y += player.gravity
	else:
		player.velocity.y = 0
