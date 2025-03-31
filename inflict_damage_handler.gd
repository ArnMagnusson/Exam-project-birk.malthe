extends Node2D
@export var damage = 1

func get_damage():
	return damage
	
#tilføj on body entered hvis i group player. body.take_Damage 
#not added yet cause slime needs a area2D for detecting if a player is hit.
