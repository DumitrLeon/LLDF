extends State_enemy
class_name Chasing

var player : Player

var engaging_distance := 3.5
var lost_timer := 0.0
var turn_timer := 0.0

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	anim.play("Chasing")

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	var dir = (enemy.global_position - player.global_position)
	var fixed_dir = dir - (Vector2(-engaging_distance, 0) if dir.x < 0 else Vector2(engaging_distance, 0))
	var move_dir = sign(fixed_dir)
	
	
	if (abs(dir.x) < engaging_distance + 2):
		enemy.velocity.x = 0
	else:
		enemy.velocity.x = -move_dir.x * enemy.chasing_speed * 2
	if enemy.velocity.x != 0:
		anim.play("Chasing")
		if enemy.velocity.x > 0:
			if enemy.facing == -1:
				enemy.sprite.flip_h = true
				enemy.facing = 1
				enemy.view.find_child("CollisionShape2D").position.x = 190.776
				enemy.view_ray.position.x = 22.681
				enemy.view_ray.position.x = -5.0
		else:
			if enemy.facing == 1:
				enemy.sprite.flip_h = false
				enemy.facing = -1
				enemy.view.find_child("CollisionShape2D").position.x = -190.776
				enemy.view_ray.position.x = -22.681
				enemy.view_ray.position.x = 5.0
	else:
		anim.play("Idle_attacking")
	
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity
	
	if not can_see_enemy():
		lost_timer += delta
		turn_timer += delta
		
		if turn_timer > 1.2:
			turn_timer = 0.0
			turn_side()
		
		if lost_timer > 5.0:
			print("basta me son rotto il cazzo")
			Transitioned.emit(self, "Patrolling")
		
	else:
		lost_timer = 0.0
		turn_timer = 0.0
	
	enemy.move_and_slide()

func turn_side():
	print("mi son girato per cercarti")

func can_see_enemy() -> bool:
	var dir = enemy.view_ray.to_local(player.global_position)
	enemy.view_ray.target_position = dir
	enemy.view_ray.force_raycast_update()
	
	if enemy.view_ray.is_colliding():
		var hit = enemy.view_ray.get_collider()
		if hit == player:
			return true
		else:
			return false
	else:
		return false
