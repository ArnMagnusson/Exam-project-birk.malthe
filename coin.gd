extends Node2D

func _on_pickup_area_body_entered(body: Node2D) -> void:
	Economy.gold += 10
	print("got gold")
	queue_free()
