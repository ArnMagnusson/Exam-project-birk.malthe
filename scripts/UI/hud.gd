extends Control
#@onready var gold maybe we will see
@onready var Healthbar = $Health/healthbar

func updatehealthbar(health, max_health):
	Healthbar.max_value = max_health
	Healthbar.value = health
	
