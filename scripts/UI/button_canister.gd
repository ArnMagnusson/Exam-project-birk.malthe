extends Control
@onready var woosh = $"../text/credit bamboo wosh"

func _ready():
	woosh.hide()

#Main menu
func _on_exit_pressed():
	get_tree().quit()

func _on_options_pressed():
	pass # Replace with function body.

func _on_start_pressed():
	Loadmanager.next_scene = "res://scenes/rooms/room1.tscn"
	get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
	
func _on_credits_pressed():
	woosh.show()
