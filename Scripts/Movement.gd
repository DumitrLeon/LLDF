extends State
class_name Movement

func Enter():
	pass


func Update(_delta: float):
	if Input.is_action_pressed("sprint"):
		player.velocity.x = player.dir * player.speed * 3
	else:
		player.velocity.x = player.dir * player.speed


func Physics_process(delta: float) -> void:
	pass


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
