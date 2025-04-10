extends Control
#@onready var gold maybe we will see

func updatehealthbar(health, max_health):
	if health == 2:
		$"Health/Full heart".hide()
	elif health == 1:
		$"Health/half heart".hide()
	elif health == 0:
		$"Health/querter heart".hide()
