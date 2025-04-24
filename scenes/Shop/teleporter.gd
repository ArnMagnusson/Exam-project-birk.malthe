extends Node2D



func _on_teleporter_detec_body_entered(body):
	Loadmanager.next_scene = "res://scenes/bossroom.tscn" #sets loadmanager next scene to next scene
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn") #loads loading screen
