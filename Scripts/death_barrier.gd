extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player = get_tree().get_first_node_in_group("Player")
		player.global_position = Vector2(160.0, 489.0) 
