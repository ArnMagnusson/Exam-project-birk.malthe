extends Control
@onready var Healthbar = $Health/healthbar

func _process(delta):
	howmuchgold()
	howmanyenemies()
	
func updatehealthbar(health, max_health): #update healthbar function
	Healthbar.max_value = max_health #sætter max value til max health
	Healthbar.value = health #sætter value til nuværende health på player
	
func howmuchgold():
	$gold/Label.text = str(Economy.gold)
	
func howmanyenemies():
	if get_tree().get_nodes_in_group("Enemies").size():
		$enemycounter/enemylabel.text = str(get_tree().get_nodes_in_group("Enemies").size())
		
	if get_tree().get_nodes_in_group("Enemies").size() < 0:
		$enemycounter.hide()
