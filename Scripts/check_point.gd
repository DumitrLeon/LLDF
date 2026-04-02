extends ColorRect
class_name CheckPoint


func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if body == player:
		color = "70e700"
		player.last_check_point = position
		$Area2D.body_entered.disconnect(_on_area_2d_body_entered)
