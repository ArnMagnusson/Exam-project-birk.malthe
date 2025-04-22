extends Node2D


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Key get")
		Playerstats.key = true
		queue_free()
