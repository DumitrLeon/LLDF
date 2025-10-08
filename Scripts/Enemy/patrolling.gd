extends State_enemy
class_name Patrolling

var direction : int = 1

func Enter():
	direction = 1
	anim.play("Walk")
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	if not fsm or not enemy:
		return
	
	enemy.velocity.x = direction * enemy.speed
	
	enemy.move_and_slide()
	
	if enemy.is_on_wall():
		_flip_direction(enemy)
	
	if not enemy.ground_check.is_colliding():
		_flip_direction(enemy)
	
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity
	
	for body in enemy.view.get_overlapping_bodies():
		if body.is_in_group("Player"):
			print("Porca madonna eccoti non ti trovavo!")
			Transitioned.emit(self, "Chasing")


func _flip_direction(enemy):
	direction *= -1
	if direction == -1:
		enemy.sprite.flip_h = false
	else:
		enemy.sprite.flip_h = true
	enemy.ground_check.position.x *= -1
	enemy.view.position.x =  (enemy.view.position.x * -1) - enemy.view.find_child("CollisionShape2D").shape.size.x
	
