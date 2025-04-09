extends Control

@onready var healthbar = $Health/health
@onready var gold = $gold

func updatehealthbar(health, max_health):
	if health == 2:
		$"Health/Full heart".hide()
	elif health == 1:
		$"Health/half heart".hide()
	elif health == 0:
		$"Health/querter heart".hide()
