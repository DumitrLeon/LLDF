extends State
class_name Jump


func Enter():
	player.jump = true
	if x_input() == 0:
		anim.play("Jump_up")
	else:
		anim.play("Jump_side")



func Update(_delta: float):
	if (anim.animation == "Jump_up" or anim.animation == "Jump_side")  and anim.frame > 2:
		Transitioned.emit(self, "Idle_air")


func _physics_process(delta: float) -> void:
	if check_floor() and anim.frame > 0:
		Transitioned.emit(self, "Idle")
