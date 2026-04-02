extends Node
class_name Enemy_state

signal Transitioned

var enemy: CharacterBody2D
var enemy_sprite : Sprite2D
var anim: AnimationPlayer
var view_ray: RayCast2D
var ground_check: RayCast2D
var area_sight : Area2D
func _ready() -> void:
	enemy = get_parent().get_parent()
	enemy_sprite = enemy.find_child("Sprite2D")
	anim = enemy.find_child("AnimationPlayer")
	view_ray = enemy.find_child("view_ray")
	ground_check = enemy.find_child("ground_check")
	area_sight = enemy.find_child("View")


func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_process(delta: float) -> void:
	pass
