extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned
var player
var anim
var StateMachine = FiniteStateMachine

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

func Physics_process(delta: float) -> void:
	pass
