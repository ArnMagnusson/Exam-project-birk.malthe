extends Node2D

func _ready():
	pass
	
func _process(delta):
	get_tree().get_nodes_in_group("Enemies").size()
	
func unregister_enemy(): #called by enemy unregister enemy
	get_tree().get_nodes_in_group("Enemies").size()
	
func register_enemy(): #called by enemy registers enemy to counter
	get_tree().get_nodes_in_group("Enemies").size()


func _on_goali_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("hey")
	if get_tree().get_nodes_in_group("Enemies").size() == 0:
		Loadmanager.next_scene = "res://scenes/rooms/room1.tscn" #sets loadmanager next scene to next scene
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn") #loads loading screen
