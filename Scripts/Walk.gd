extends State
class_name Walk


func Enter():
	anim.play("Walk")


func Update(_delta: float):
	if anim.frame != 0:
		player.velocity.x = x_input() * player.speed
	else:
		player.velocity.x = x_input() * (player.speed / 2)
	
	if Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Run")
	
	if x_input() == 0:
		Transitioned.emit(self, "Idle")
	
	if check_jump():
		Transitioned.emit(self, "Jump")


func _physics_process(delta: float) -> void:
	if not check_floor():
		Transitioned.emit(self, "Idle_air")
