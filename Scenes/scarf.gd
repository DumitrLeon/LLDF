extends Node2D
class_name Scarf

@onready var mark: Marker2D = $Marker2D
@onready var anchor_pos = Vector2()
@onready var player_sprite: Sprite2D = get_parent().get_node("Player_sprite")
@onready var scarf_head: Sprite2D = get_parent().get_node("Scarf_head")

var radius: float = 2.0
var iterations: int = 25
@export var gravity: Vector2 = Vector2(0, 500)
@export var points_count: int = 50


@onready var part: Line2D = $SubViewportContainer/SubViewport/part_1
@onready var anchor: Marker2D = $Marker2D

var points: Array[Vector2] = []
var prev_points: Array[Vector2] = []

func _ready() -> void:
	points.clear()
	prev_points.clear()
	
	for i in range(points_count):
		var p = mark.position + Vector2(-i * radius, 0)
		points.append(p)
		prev_points.append(p)
	print(points[0], "   ", mark.position)
	print(points[0], "   ", mark.position)
	part.points = points

func _physics_process(delta: float) -> void:
	update_anchor()
	verlet_step(delta)
	for i in range(iterations):
		solve_constraints()
	
	part.points = points

func update_anchor():
	if player_sprite.flip_h:
		scarf_head.flip_h = true
		scarf_head.position = mark.position - Vector2(1.1,-1) - Vector2(mark.position.x *2, 0)
		points[0] = mark.position - Vector2(mark.position.x *2, 0) + Vector2(50,50)
	else:
		scarf_head.flip_h = false
		scarf_head.position = mark.position + Vector2(1.02,0.7)
		points[0] = mark.position + Vector2(50,50) + Vector2(-2,0)

func verlet_step(delta):
	for i in range(1, points.size()):
		
		var velocity := points[i] - prev_points[i]
		
		prev_points[i] = points[i]
		
		points[i] += velocity
		points[i] += gravity * delta * delta
		

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
