extends Node2D

func _on_chest_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var treasurescene = preload("res://treasure.tscn")
		var instance = treasurescene.instantiate()
		instance.global_position = global_position
		get_parent().add_child(instance)
		queue_free()
