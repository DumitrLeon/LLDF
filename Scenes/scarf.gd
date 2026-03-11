extends Node2D
class_name Scarf

@onready var mark: Marker2D = $Scarf_head_marker
@onready var mark_anchor: Marker2D = $Anchor_marker
@onready var anchor_pos = Vector2()
@onready var player: CharacterBody2D = get_parent()
@onready var player_sprite: Sprite2D = get_parent().get_node("Player_sprite")
@onready var scarf_head: Sprite2D = get_parent().get_node("Scarf_head")

@export var radius: float = 2.0
@export var iterations: int = 25
@export var gravity: Vector2 = Vector2(0, 1000)
@export var points_count: int = 10
var prev_points_count: int


@onready var part: Line2D = $SubViewportContainer/SubViewport/part_1
@onready var anchor: Marker2D = $Marker2D

var points: Array[Vector2] = []
var prev_points: Array[Vector2] = []
var scarf_fix = 50
var collisions: Array[StaticBody2D] = []

func _ready() -> void:
	prev_points_count = points_count
	points.clear()
	prev_points.clear()
	
	for i in range(points_count):
		var p = mark.position + Vector2(-i * radius, 0)
		points.append(p)
		prev_points.append(p)
		
		var static_body = StaticBody2D.new()
		var collision = CollisionShape2D.new()
		var shape = CircleShape2D.new()
		shape.radius = 2
		collision.shape = shape
		static_body.position = p
		collisions.append(static_body)
		static_body.add_child(collision)
		
		static_body.collision_layer = 0
		static_body.collision_mask = 0
		
		add_child(static_body)
		
	part.points = points

func _input(event: InputEvent) -> void:
	if event is  InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var dir = (points[points_count-1] - points[points_count-2]).normalized()
			var p = points[points_count-1] + dir * radius
			points.append(p)
			prev_points.append(p)
			part.points = points
			points_count += 1
			
		if event.button_index == MOUSE_BUTTON_RIGHT:
			points.pop_front()
			prev_points.pop_front()
			part.points = points
			points_count -= 1

func _physics_process(delta: float) -> void:
	update_anchor(delta)
	verlet_step(delta)
	for i in range(iterations):
		solve_constraints()
	
	part.points = points

func update_anchor(delta):
	if player_sprite.flip_h:
		scarf_head.flip_h = true
		scarf_head.position = mark.position - Vector2(1.1,-1) - Vector2(mark.position.x *2, 0)
		mark_anchor.position = mark_anchor.position.move_toward(mark.position, scarf_fix*delta)
		points[0] = mark_anchor.position - Vector2(mark_anchor.position.x *2, 0) + Vector2(200,200)
	else:
		scarf_head.flip_h = false
		scarf_head.position = mark.position + Vector2(1.02,0.7)
		mark_anchor.position = mark_anchor.position.move_toward(mark.position, scarf_fix*delta)
		points[0] = mark_anchor.position + Vector2(200,200) + Vector2(-2,0)

func verlet_step(delta):
	for i in range(1, points.size()):
		
		var velocity := points[i] - prev_points[i]
		
		prev_points[i] = points[i]
		
		var accel = gravity
		accel.x -= player.velocity.x * 15
		accel.y -= player.velocity.y * 15
		
		if mark.position.y > 4:
			accel.y -= 0.5
		
		points[i] = points[i] + velocity + accel * delta * delta
		
		collisions[i].position = points[i]

func solve_constraints():
	
	for j in range(iterations):
		
		for i in range(1, points.size()):
			
			var dir := points[i] - points[i-1]
			var dist := dir.length()
			
			if dist == 0:
				continue
			
			var diff := (dist - radius) / dist
			
			if i == 1:
				points[i] -= dir * diff
			else:
				points[i-1] += dir * diff * 0.5
				points[i] -= dir * diff * 0.5
