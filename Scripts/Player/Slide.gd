extends State
class_name Slide

var timer = 0.0
var slide_power = 200
var direction = false

func Enter():
	anim.play("Slide")
	timer = 0.0
	if player.dir == 0:
		direction = not player_sprite.flip_h
	else:
		direction = (true if player.dir == 1 else false)


func Update(_delta: float):
	player.velocity.x = slide_power * (1 if direction else -1)
	timer += _delta
	if timer > 0.25:
		Transitioned.emit(self, "Idle")
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.x += (-170 if player.velocity.x < 0 else 170)
		Transitioned.emit(self, "jump")

func Physics_process(delta: float) -> void:
	if not player.is_on_floor():
		Transitioned.emit(self, "Idle_Air")
