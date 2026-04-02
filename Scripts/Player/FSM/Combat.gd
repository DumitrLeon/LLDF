extends State
class_name Combat

@onready var scarf = get_parent().get_parent().find_child("Scarf")
@onready var movement_preload = preload("res://Scripts/Player/FSM/Movement.gd")
var movement: Movement

var combo = false
var combo_count = 0

func Enter():
	movement = movement_preload.new()
	combo = false
	combo_count = 1
	
	tiny_slide()
	
	if player.get_meta("attack") == "basic":
		anim.play("Attack_combo_1")
		scarf_anim.play("Attack_combo_1")

var prev_points_fix = [Vector2(2.0, -6.0), Vector2(47.6103, 44.92051), Vector2(48.2102, 48.36872), Vector2(48.90875, 51.7983), Vector2(49.74928, 55.19588), Vector2(50.8032, 58.53343), Vector2(52.18108, 61.7508)]
var points_fix = [Vector2(47.073, 41.462), Vector2(47.42936, 44.94381), Vector2(47.82687, 48.42117), Vector2(48.29104, 51.89025), Vector2(48.85519, 55.34449), Vector2(49.57838, 58.76896), Vector2(50.56308, 62.12759)]

func tiny_slide():
	if Input.is_action_pressed("left"):
		player.velocity.x = -50
	elif Input.is_action_pressed("right"):
		player.velocity.x = 50

func Update(_delta: float):
	fix_anim_dir()
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.friction / 2 * _delta)
	if combo:
		#attacco normale a terra
		if (movement.check_floor(player)) and (Input.is_action_just_pressed("First_button")):
			combo = false
			if combo_count == 1:
				tiny_slide()#PICCOLO SLIDE PK BOH PENSO FA FIGO
				combo_count += 1
				anim.play("Attack_combo_2")
				scarf_anim.play("Attack_combo_2")
			elif combo_count == 2:
				tiny_slide()
				combo_count = 0
				anim.play("Attack_combo_3")
				scarf_anim.play("Attack_combo_3")
		
		#CONTROLLI DI USCITA-----------
		if Input.is_action_just_pressed("jump"):
			if movement.check_jump(player, true):
				combo = false
				anim.stop()
				scarf_anim.stop()
				fix_anim_dir()
				Transitioned.emit(self, "Jump")
		
		if Input.is_action_just_pressed("slide"):
			if movement.check_slide(player, true):
				combo = false
				anim.stop()
				scarf_anim.stop()
				fix_anim_dir()
				Transitioned.emit(self, "Slide")
		

func Physics_process(delta: float) -> void:
	if not movement.check_floor(player):
		anim.stop()
		scarf_anim.stop()
		fix_anim_dir()
		Transitioned.emit(self, "Idle")

func fix_anim_dir():
	scarf = get_parent().get_parent().find_child("Scarf")
	if scarf:
		if player_sprite.scale.x < 0:
			scarf.scale.x = abs(scarf.scale.x) * -1
		else:
			scarf.scale.x = abs(scarf.scale.x)

func on_attack_reload():
	combo = true

func fix_finish_physics():
	for i in range(len(scarf.points)):
		scarf.prev_points[i] = prev_points_fix[i]
		scarf.points[i] = points_fix[i]

func on_attack_finished():
	Transitioned.emit(self, "Idle")

func Exit():
	scarf.scale.x = abs(scarf.scale.x)
	for i in range(len(scarf.points)):
		scarf.prev_points[i] = prev_points_fix[i]
		scarf.points[i] = points_fix[i]
