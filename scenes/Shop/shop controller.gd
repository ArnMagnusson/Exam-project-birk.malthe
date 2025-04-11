extends Control

func _ready():
	howmuchgold()


func _on_gloves_pressed():
	if Economy.gold > 120: #if above 120 gold allow buy
		Economy.gold -= 120
		Playerstats.strength += 2
		Playerstats.fortitude += 1
		$gloves/Gauntlet.hide()

func _on_chestplate_pressed():
	if Economy.gold > 180:
		Economy.gold -= 180
		Playerstats.constitution += 2
		Playerstats.fortitude += 1
		$chestplate/Chestplate.hide()

func _on_leggings_pressed():
	if Economy.gold > 140:
		Economy.gold -= 140
		Playerstats.fortitude += 2
		Playerstats.speedbonus += 1
		$leggings/Leggings.hide()
	
func _on_glaive_pressed():
	if Economy.gold > 200:
		Economy.gold -= 200
		Playerstats.crit += 2
		$glaive/Doubleglaive.hide()

func _on_helmet_pressed():
	if Economy.gold > 160:
		Economy.gold -= 160
		Playerstats.fortitude += 2
		Playerstats.constitution += 1
		$helmet/Helmet.hide()

func _on_boots_pressed():
	if Economy.gold > 100:
		Economy.gold -= 100
		Playerstats.speedbonus += 2
		Playerstats.fortitude += 1
		$boots/Boots.hide()
		
func howmuchgold():
	$"../Control/Label".text = str(Economy.gold) #shows gold by turning gold into a string
