extends Enemy_state
class_name Chasing

@onready var patrolling_preload = preload("res://Scripts/Enemies/Patrolling.gd")
var patrolling : Patrolling

func Enter():
	patrolling = patrolling_preload.new()

func Update(_delta: float):
	var player_position = get_tree().get_first_node_in_group("Player").global_position
	var enemy_position = enemy.global_position
	
	var direction = (1 if player_position.x > enemy_position.x else -1)
	
	patrolling.turn_fix(enemy_sprite, ground_check, area_sight, direction)
	
	anim.play("Chasing")
	if direction == 1:
		enemy.velocity.x = enemy.chasing_speed
	elif direction == -1:
		enemy.velocity.x = enemy.chasing_speed * -1
	
	var player = get_tree().get_first_node_in_group("Player")
	if not patrolling.sees_player(view_ray, player):
		Transitioned.emit(self, "Patrolling")


func Physics_process(delta: float) -> void:
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity * delta
	
	enemy.move_and_slide()
