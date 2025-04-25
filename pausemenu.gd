extends Control

@onready var pausescreen: CanvasLayer = $pausescreen
@onready var statscreen: CanvasLayer = $statscreen
@onready var strstat: Label = $statscreen/strstat
@onready var forstat: Label = $statscreen/forstat
@onready var constat: Label = $statscreen/constat
@onready var goldstat: Label = $statscreen/goldstat
@onready var speedstat: Label = $statscreen/speedstat


var pause

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	update_stats()
	if Input.is_action_pressed("esc"):
		print("paused")
		pausescreen.visible = true
		statscreen.visible = true
		pause = true
		get_tree().paused = true
		

func _on_continuebutton_pressed() -> void:
	pausescreen.hide()
	statscreen.hide()
	pause = false
	get_tree().paused = false

func _on_restartbutton_pressed() -> void:
	get_tree().paused = false
	Economy.gold = 0
	Playerstats.constitution = 0
	Playerstats.fortitude = 1
	Playerstats.strength = 1
	Playerstats.gold_multiplier = 1
	Playerstats.speedbonus = 1
	get_tree().change_scene_to_file("res://scenes/rooms/room1.tscn")
	
func _on_titlescreenbutton_pressed() -> void:
	get_tree().paused = false
	Economy.gold = 0
	Playerstats.constitution = 0
	Playerstats.fortitude = 1
	Playerstats.strength = 1
	Playerstats.gold_multiplier = 1
	Playerstats.speedbonus = 1
	get_tree().change_scene_to_file("res://scenes/UI/Main_Menu.tscn")
	

func _on_quitbutton_pressed() -> void:
	get_tree().quit()

func update_stats():
	$statscreen/strstat.text = str(Playerstats.strength)
	$statscreen/forstat.text = str(Playerstats.fortitude)
	$statscreen/constat.text = str(Playerstats.constitution)
	$statscreen/goldstat.text = str(Playerstats.gold_multiplier)
	$statscreen/speedstat.text = str(Playerstats.speedbonus)
