extends StaticBody2D
@export var health = 100

func Take_damage(damage_amount):
	print("damage taken", damage_amount)
	if health <= 0:
		die()
		
func die():
	print("training dummy dead")
	queue_free()
