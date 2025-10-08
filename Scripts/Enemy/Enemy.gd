extends CharacterBody2D
class_name Enemy

@export var gravity = 15
@export var speed: float = 40.0

@onready var test : Area2D = $test
@onready var ground_check : RayCast2D = $RayCast2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var view : Area2D = $View
