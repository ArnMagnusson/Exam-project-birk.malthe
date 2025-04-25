extends Control
@onready var deathscreen: CanvasLayer = $deathscreen

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_restartbutton_pressed() -> void:
	Economy.gold = 0
	Playerstats.constitution = 0
	Playerstats.fortitude = 1
	Playerstats.strength = 1
	Playerstats.gold_multiplier = 1
	Playerstats.speedbonus = 1
	get_tree().change_scene_to_file("res://scenes/rooms/room1.tscn")
	
func _on_titlescreenbutton_pressed() -> void:
	Economy.gold = 0
	Playerstats.constitution = 0
	Playerstats.fortitude = 1
	Playerstats.strength = 1
	Playerstats.gold_multiplier = 1
	Playerstats.speedbonus = 1
	get_tree().change_scene_to_file("res://scenes/UI/Main_Menu.tscn")
	

func _on_quitbutton_pressed() -> void:
	get_tree().quit()
