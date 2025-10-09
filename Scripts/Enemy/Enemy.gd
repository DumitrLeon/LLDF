extends CharacterBody2D
class_name Enemy

@export var gravity = 15
@export var patrolling_speed: float = 35.0
@export var chasing_speed: float = 43.0
@export var turning_timer := 0.5
@export_enum("Sinistra:-1", "Destra:1") var facing : int = 1

@onready var test : Area2D = $test
@onready var ground_check : RayCast2D = $ground_check
@onready var sprite : Sprite2D = $Sprite2D
@onready var view : Area2D = $View
@onready var view_ray : RayCast2D = $view_ray

var is_ready = false

func _ready() -> void:
	is_ready = true
