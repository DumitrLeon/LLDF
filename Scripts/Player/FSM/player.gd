extends CharacterBody2D
class_name Player

@export var abilità := {
	"double_jump": false,
	"slide": false
}

enum Scarfs_powers {
	NONE,
	DEFAULT,
	FIRE
}

var scarfs_unlocked: Array[Scarfs_powers] = [Scarfs_powers.DEFAULT]

var max_jumps = 2
@export var walking_speed = 70
@export var sprinting_speed = 140
@export var jump_boost = -360
@export var gravity = 1000
@export var friction = 500
@onready var cojote_jump: Timer = $Timers/CojoteJump
@onready var slide_timer: Timer = $Timers/Slide_timer

#TESTING PURPOSIESSSS
var last_check_point: Vector2 = Vector2(-3166.0, 490.0)
#TESTING PURPOSIESSSS

var dir = 0 #PER LA DIREZIONE WOWOWOWOWOWOWOEWOWOWOWOWOW
var jump = false
var jumps_made = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	dir = Input.get_axis("left", "right") #prende input per dir (1 o -1) 
	if jump:
		jump = false

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$Player_sprite.scale.x = abs($Player_sprite.scale.x)
	elif velocity.x < 0:
		$Player_sprite.scale.x = abs($Player_sprite.scale.x) * -1
	
	move_and_slide()
