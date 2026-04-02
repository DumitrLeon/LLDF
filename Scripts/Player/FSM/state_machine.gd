extends Node
class_name FiniteStateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
		
		if initial_state:
			current_state = initial_state
			current_state.Enter()

func _process(_delta: float) -> void:
	if current_state:
		current_state.Update(_delta)

func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.Physics_process(_delta)

func on_child_transitioned(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	current_state = new_state
	current_state.Enter()
