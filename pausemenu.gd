extends Control

@onready var pausescreen: CanvasLayer = $pausescreen
@onready var player: CharacterBody2D = $player
var pause

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		print("paused")
		pausescreen.visible = true
		pause = true
		get_tree().paused = true
		

func _on_continuebutton_pressed() -> void:
	pausescreen.hide()
	pause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_restartbutton_pressed() -> void:
	get_tree().paused = false
	Economy.gold = 0
	get_tree().change_scene_to_file("res://scenes/rooms/room1.tscn")
	
func _on_titlescreenbutton_pressed() -> void:
	get_tree().paused = false
	Economy.gold = 0
	get_tree().change_scene_to_file("res://scenes/UI/Main_Menu.tscn")
	

func _on_quitbutton_pressed() -> void:
	get_tree().quit()
