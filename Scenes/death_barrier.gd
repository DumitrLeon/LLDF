extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if body == player:
		player.position = player.last_check_point + Vector2(20,-10)
