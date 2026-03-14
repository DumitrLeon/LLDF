extends Node2D
class_name Scarf

@onready var mark: Marker2D = $Scarf_head_marker
@onready var mark_anchor: Marker2D = $Anchor_marker
@onready var anchor_pos = Vector2()
@onready var player: CharacterBody2D = get_parent()
@onready var player_sprite: Sprite2D = get_parent().get_node("Player_sprite")
@onready var scarf_head: AnimatedSprite2D = get_parent().get_node("Player_sprite").get_node("Scarf_head")

@export var radius: float = 2.0
@export var iterations: int = 25
@export var gravity: Vector2 = Vector2(0, 1500)
@export var points_count: int = 10
var prev_points_count: int


@onready var part: Line2D = $SubViewportContainer/SubViewport/part_1
@onready var anchor: Marker2D = $Marker2D

var points: Array[Vector2] = []
var prev_points: Array[Vector2] = []
var scarf_fix = 200
var pos_fix = Vector2(50, 50)

var external_force = false
var physic_timer = 0.0

var space_state
func _ready() -> void:
	# usa il mondo della scena principale
	space_state = get_tree().current_scene.get_world_2d().direct_space_state

	prev_points_count = points_count
	points.clear() 
	prev_points.clear()
	
	for i in range(points_count):
		var p = mark.position + Vector2(-i * radius, 0)
		points.append(p)
		prev_points.append(p)
		
	part.points = points

func _physics_process(delta: float) -> void:
	if player.dir == 0:
		physic_timer += delta
	else:
		physic_timer = 0.0
	
	if physic_timer < 5.0:
		update_anchor(delta)
		verlet_step(delta)
		for i in range(iterations):
			solve_constraints()
			solve_world_collisions()
	
	part.points = points

func update_anchor(delta):
	if player_sprite.scale.x < 0:
		mark_anchor.position = mark_anchor.position.move_toward(mark.position, scarf_fix*delta)
		points[0] = mark_anchor.position - Vector2(mark_anchor.position.x *2, 0) + pos_fix
	else:
		mark_anchor.position = mark_anchor.position.move_toward(mark.position, scarf_fix*delta)
		points[0] = mark_anchor.position + pos_fix + Vector2(-2,0)


func solve_world_collisions():
	for i in range(1, len(part.points)):
		var from_pos = to_global(prev_points[i]) - pos_fix
		var to_pos = to_global(points[i]) - pos_fix
		
		var ray_query = PhysicsRayQueryParameters2D.new()
		ray_query.from = from_pos
		ray_query.to = to_pos
		ray_query.exclude = [self, player]
		
		var result = space_state.intersect_ray(ray_query)
		  
		if result:
			var dir: Vector2 = to_pos - result.position
			var length = dir.length()
			
			points[i] += result.normal * (length if length > 0 else 0.1)

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
		solve_world_collisions()

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

signal change_skin
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_LEFT:
			print("Hai premuto sinistra!")
			change_skin.emit("sinistra!")
		elif event.keycode == KEY_RIGHT:
			print("Hai premuto destra!")
			change_skin.emit("destra!")
	
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
