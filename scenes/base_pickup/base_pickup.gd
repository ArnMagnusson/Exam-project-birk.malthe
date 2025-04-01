extends Node2D
signal Pick_upped

func _on_pickup_area_area_entered(area):
		print("BOOST")
		emit_signal("Pick_upped")
		queue_free()
