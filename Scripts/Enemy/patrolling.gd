extends State_enemy
class_name Patrolling

var direction : int

var patroll_controls := false
var temp

var timer_fix : float = 0.5

func Enter():
	anim.play("Walk")
	patroll_controls = false
	while not enemy.is_ready:
		await get_tree().create_timer(0.5).timeout
	temp = enemy.turning_timer
	direction = enemy.facing
	if direction == -1:
		if enemy.sprite:
			enemy.sprite.flip_h = false
		if enemy.view:
			enemy.view.find_child("CollisionShape2D").position.x = -190.776
		if enemy.ground_check:
			enemy.ground_check.position.x = -22.681
	else:
		if enemy.sprite:
			enemy.sprite.flip_h = true
		if enemy.view:
			enemy.view.find_child("CollisionShape2D").position.x = 190.776
		if enemy.ground_check:
			enemy.ground_check.position.x = 22.681

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	if not fsm or not enemy:
		return
	if timer_fix > 0:
		timer_fix -= delta
	
	if enemy.is_on_floor() and patroll_controls == false:
		patroll_controls = true
	
	if temp == enemy.turning_timer:
		enemy.velocity.x = direction * enemy.patrolling_speed
		if anim.current_animation == "Idle":
			anim.play("Walk")
	else:
		enemy.velocity.x = 0
		if anim.current_animation == "Walk":
			anim.play("Idle")
	
	
	if (enemy.is_on_wall()) and (patroll_controls):
		if timer_fix <= 0:
			handle_flip(delta)
	
	if (not enemy.ground_check.is_colliding()) and (patroll_controls):
		if timer_fix <= 0:
			handle_flip(delta)
	
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity
	
	#qua controlla se rileva il player nell'area
	var player
	for body in enemy.view.get_overlapping_bodies():
		if body.is_in_group("Player"):
			player = body
		else:
			player = null
	
	#PUNTAMENTO VERSO PLAYER
	if player:
		var dir = enemy.view_ray.to_local(player.global_position)
		enemy.view_ray.target_position = dir
		enemy.view_ray.force_raycast_update()
		
		if enemy.view_ray.is_colliding():
			var hit = enemy.view_ray.get_collider()
			if hit == player:
				Transitioned.emit(self, "Chasing")
	print(temp)
	enemy.move_and_slide()

func handle_flip(delta):
	if temp > 0.0:
		temp -= delta
	else:
		_flip_direction(enemy)

func _flip_direction(enemy):
	timer_fix = 0.5
	temp = enemy.turning_timer
	direction *= -1
	if direction == -1:
		enemy.sprite.flip_h = false
	else:
		enemy.sprite.flip_h = true
	enemy.ground_check.position.x *= -1
	enemy.view.find_child("CollisionShape2D").position.x *= -1
