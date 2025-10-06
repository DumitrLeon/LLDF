extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned
var StateMachine = FiniteStateMachine
var Anim
var player
var anim

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	anim = player.find_child("AnimatedSprite2D")
	StateMachine = get_parent()
	Anim = player.find_child("AnimatedSprite2D")

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
	if not player.is_on_floor() and player.is_inside_tree():
		player.velocity.y += player.gravity
		
