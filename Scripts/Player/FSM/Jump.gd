extends Movement
class_name Jump

var anim_pos = 0
func Enter():
	if player.jumps_made > 1:
		anim.play("Roll")
	anim_pos = 0
	player.velocity.y = player.jump_boost


func Update(_delta: float):
	super.Update(_delta)
	if player.velocity.y > -60:
		Transitioned.emit(self, "Idle_air")
	
	if not Input.is_action_pressed("jump"):
		player.velocity.y = move_toward(player.velocity.y, 0.0, 10)


func Physics_process(delta: float) -> void:
	apply_gravity(player, delta)
	if check_floor(player):
		Transitioned.emit(self, "idle")
		
	
	if player.jumps_made > 1:
		pass
	else:
		#sto casino qui sotto per evitare spam di switch del tipo di salto
		if player.dir == 0:
			if anim.current_animation != "Jump_up":
				anim.play("Jump_up")
				anim.seek(anim_pos, true)
			anim_pos = anim.current_animation_position
		else:
			if anim.current_animation != "Jump_side":
				anim.play("Jump_side")
				anim.seek(anim_pos, true)
			anim_pos = anim.current_animation_position
