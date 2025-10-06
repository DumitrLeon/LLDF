extends State
class_name Run

func Enter():
	anim.play("Run")

func Update(_delta: float):
	player.velocity.x = x_input() * player.speed * 3.54
	
	if Input.is_action_just_released("sprint"):
		Transitioned.emit(self, "Walk")
	
	if x_input() == 0:
		Transitioned.emit(self, "Idle")

func _physics_process(delta: float) -> void:
	if not check_floor():
		Transitioned.emit(self, "Idle_air")
