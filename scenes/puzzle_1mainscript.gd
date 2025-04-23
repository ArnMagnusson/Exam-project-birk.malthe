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
