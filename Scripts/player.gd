extends CharacterBody2D
class_name Player

@export var speed = 50
@export var jump_boost = -350
@export var gravity = 20
var dir = 0 #PER LA DIREZIONE WOWOWOWOWOWOWOEWOWOWOWOWOW

var jump = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	dir = Input.get_axis("left", "right")
	if jump:
		jump = false
		velocity.y = jump_boost

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	move_and_slide()
