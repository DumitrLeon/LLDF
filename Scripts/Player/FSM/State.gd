extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned
var player : Player
var camera : Camera2D
var collision_player : CollisionShape2D
var RayCasts : Array[RayCast2D] = []
var anim : AnimationPlayer
var scarf_anim : AnimationPlayer
var player_sprite: Sprite2D
var StateMachine = FiniteStateMachine

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	for child in player.find_child("RayCasts").get_children():
		RayCasts.append(child as RayCast2D)
	collision_player = player.find_child("CollisionShape2D")
	player_sprite = player.find_child("Player_sprite")
	camera = player.find_child("Camera2D")
	anim = player.find_child("AnimationPlayer")
	scarf_anim = player.find_child("Scarf").find_child("AnimationScarf")
	StateMachine = get_parent()

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	pass
