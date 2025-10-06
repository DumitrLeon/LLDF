extends CharacterBody2D
class_name Player

@export var speed = 50
@export var jump_boost = -300
@export var gravity = 20

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()
