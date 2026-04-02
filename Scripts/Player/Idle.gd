extends Movement
class_name Idle


func Enter():
	anim.play("Idle")

var camera_speed = 5
var looking_timer_length = 0.32
var looking_timer = 0
func Update(_delta: float):
	#GODMODE
	if Input.is_action_just_pressed("GodMode"):
		Transitioned.emit(self, "GodMode")
	if Input.is_action_pressed("up"):
		if looking_timer <= 0:
			if not anim.current_animation == "Idle_Lup":
				anim.play("Idle_Lup")
			camera.position.y = move_toward(camera.position.y, -100.0, camera_speed)
		looking_timer -= _delta
	elif Input.is_action_pressed("down"):
		if looking_timer <= 0:
			if not anim.current_animation == "Idle_Ldown":
				anim.play("Idle_Ldown")
			camera.position.y = move_toward(camera.position.y, 40.0, camera_speed)
		looking_timer -= _delta
	else:
		if (anim.current_animation == "Idle_Lup") or (anim.current_animation == "Idle_Ldown"):
			anim.play("Idle")
		camera.position.y = move_toward(camera.position.y, -40.0, camera_speed)
		looking_timer = looking_timer_length
	
	if player.dir != 0:
		camera.position.y = move_toward(camera.position.y, -40.0, camera_speed)
		Transitioned.emit(self, "Walk")
	if player.velocity.x != 0: #si ferma
		player.velocity.x = move_toward(player.velocity.x, 0.0, player.friction * _delta)
	
	check_attack(player)
	check_slide(player)
	check_jump(player)

func Exit():
	camera.position.y = -40.0

func Physics_process(delta: float) -> void:
	if not check_floor(player):
		camera.position.y = move_toward(camera.position.y, -40.0, camera_speed)
		player.cojote_jump.start()
		Transitioned.emit(self, "Idle_air")
