extends CharacterBody2D
class_name Player

@export var walking_speed = 70
@export var sprinting_speed = 140
@export var jump_boost = -350
@export var gravity = 20
@export var friction = 1000
@onready var cojote_jump: Timer = $Timers/CojoteJump
@onready var slide_timer: Timer = $Timers/Slide_timer
var dir = 0 #PER LA DIREZIONE WOWOWOWOWOWOWOEWOWOWOWOWOW

var jump = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	dir = Input.get_axis("left", "right") #prende input per dir (1 o -1) 
	if jump:
		jump = false

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$Player_sprite.flip_h = false
	elif velocity.x < 0:
		$Player_sprite.flip_h = true
	
	move_and_slide()
