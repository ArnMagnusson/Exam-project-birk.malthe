extends Node2D

func _on_exit_body_entered(body: Node2D) -> void:
	Loadmanager.next_scene = "res://scenes/combat.tscn" #sets loadmanager next scene to next scene
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn") #loads loading screen
