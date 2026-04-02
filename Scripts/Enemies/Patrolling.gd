extends Enemy_state
class_name Patrolling

var dir = 1
var turning_timer = 0.0

func Enter():
	print("AOIWDJAWDJ")
	turning_timer = 0.0
	if enemy_sprite.scale.x > 0:
		dir = 1
		print("dir a 1")
	elif enemy_sprite.scale.x < 0:
		dir = -1
		print("dir a -1")

func Update(_delta: float):
	if (enemy.is_on_wall()) or (not check_ground()):
		dir = 0
		turning_timer += _delta
		if turning_timer >= enemy.turn_time:
			if enemy_sprite.scale.x > 0:
				dir = -1
				enemy.position.x -= 1
			elif enemy_sprite.scale.x < 0:
				dir = 1
				enemy.position.x += 1
			turning_timer = 0.0
	else:
		turning_timer = 0.0
		if enemy_sprite.scale.x > 0:
			dir = 1
		elif enemy_sprite.scale.x < 0:
			dir = -1
	
	if player_in_sight():
		var player = get_tree().get_first_node_in_group("Player")
		if sees_player(view_ray, player):
			Transitioned.emit(self, "Chasing")
	
	turn_fix(enemy_sprite, ground_check, area_sight, dir)
	if dir == 1:
		enemy.velocity.x = enemy.speed
		anim.play("Walk")
	elif dir == -1:
		enemy.velocity.x = enemy.speed * -1
		anim.play("Walk")
	else:
		enemy.velocity.x = 0
		anim.play("Idle")
	if enemy.still:
		enemy.velocity.x = 0
		anim.play("Idle")

func player_in_sight():
	var bodies = area_sight.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Player"):
			return true
	return false

func sees_player(view_ray, player):
	view_ray.target_position = view_ray.to_local(player.global_position)
	
	if view_ray.is_colliding():
		var collider = view_ray.get_collider()
		if collider.is_in_group("Player"):
			return true
		else:
			return false

func check_ground():
	if ground_check.is_colliding():
		return true
	return false

func turn_fix(enemy_sprite, ground_check, area_sight, dir):
	if dir == 1:
		enemy_sprite.scale.x = abs(enemy_sprite.scale.x)
		ground_check.position.x = abs(ground_check.position.x)
		area_sight.find_child("CollisionShape2D").position.x = abs(area_sight.find_child("CollisionShape2D").position.x)
	elif dir == -1:
		enemy_sprite.scale.x = abs(enemy_sprite.scale.x) * -1
		ground_check.position.x = abs(ground_check.position.x) * -1
		area_sight.find_child("CollisionShape2D").position.x = abs(area_sight.find_child("CollisionShape2D").position.x) * -1

func Physics_process(delta: float) -> void:
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity * delta
	
	enemy.move_and_slide()
