extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned
var StateMachine = FiniteStateMachine
var player
var anim

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	anim = player.find_child("AnimatedSprite2D")
	StateMachine = get_parent()

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func _physics_process(delta: float) -> void:
	pass

func x_input():
	var x = Input.get_axis("left", "right")
	return x

func check_jump():
	if Input.is_action_just_pressed("jump"):
		return true
	else:
		return false

func check_floor():
	if player.is_on_floor():
		return true
	else:
		return false

func apply_gravity():
	if not check_floor():
		player.velocity.y += player.gravity
	else:
		player.velocity.y = 0
