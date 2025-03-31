extends StaticBody2D
@onready var health = 3000

func take_damage(damage_ammount):
	print("damage taken", health)
	health -=damage_ammount
