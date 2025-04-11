extends Node2D
var player = false
@onready var shop = $"../shophud"
func _ready():
	shop.hide()

func _process(delta):
	shop_open()

func _on_area_2d_body_entered(body):
		player = true
		
func _on_area_2d_body_exited(body):
		player = false
		shop.hide()
		
func shop_open():
	if player == true and Input.is_action_just_pressed("Intereact"):
		shop.show()
		print(player)
