extends Node
class_name State_enemy

signal Transitioned
var enemy : Enemy
var fsm : Enemy_fsm
var anim : AnimationPlayer

func _ready() -> void:
	fsm = get_parent()
	enemy = fsm.get_parent()
	anim = enemy.find_child("AnimationPlayer")

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	pass
