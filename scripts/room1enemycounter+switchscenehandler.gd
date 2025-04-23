extends Node2D

func _ready():
	pass
	
func _process(delta):
	pass
	
func unregister_enemy(): #called by enemy unregister enemy
	Playerstats.enemies -= 1
	print(Playerstats.enemies, "enemy count")
	
func register_enemy(): #called by enemy registers enemy to counter
	Playerstats.enemies += 1

func _on_goal_body_entered(body):
		if Playerstats.enemies == 0:
			Loadmanager.next_scene = "res://scenes/puzzle1.tscn" #sets loadmanager next scene to next scene
			get_tree().change_scene_to_file("res://scenes/loading_screen.tscn") #loads loading screen
