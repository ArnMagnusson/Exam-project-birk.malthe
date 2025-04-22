extends Node2D



func _on_door_area_body_entered(body: Node2D) -> void:
	if Playerstats.key == true:
		queue_free()
