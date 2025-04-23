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
	if Playerstats.enemies > 0:
		$enemycounter/enemylabel.text = str(Playerstats.enemies)
		
	if Playerstats.enemies < 0:
		$enemycounter.hide()
