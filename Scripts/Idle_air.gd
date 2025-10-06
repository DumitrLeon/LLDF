extends State
class_name Idle_air

func Enter():
	anim.play("Idle_air")

func Update(_delta: float):
	player.velocity.x = x_input()*player.speed

func _physics_process(delta: float) -> void:
	apply_gravity()
	if check_floor():
		Transitioned.emit(self, "Idle")
