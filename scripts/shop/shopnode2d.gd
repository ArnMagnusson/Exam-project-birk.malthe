extends Node2D
var player = false

func _process(delta):
	shop_open()

func _on_area_2d_body_entered(body):
		player = true
		
func _on_area_2d_body_exited(body):
		player = false
		
func shop_open():
	if player == true and Input.is_action_just_pressed("Intereact"):
		print(player)
