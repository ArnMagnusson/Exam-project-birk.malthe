extends Node2D
signal Pick_upped


func _on_pickup_area_body_entered(body):
	if body.is_in_group("Player"):
		print("BOOST")
		emit_signal("Pick_upped")
		queue_free()
