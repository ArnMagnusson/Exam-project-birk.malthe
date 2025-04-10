extends Node2D

@export var gold = 0

func _gold_check():
	if Input.is_action_just_pressed("debug"):
		print(gold)
		
func spend_gold(cost, item):
	if gold > cost:
		print("bought" + item)
	elif gold < cost:
		print("Not enough gold")
	
func Gold_dropped(gold_reward):
	gold += gold_reward
