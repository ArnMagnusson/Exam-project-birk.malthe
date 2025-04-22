extends Node2D

@export_enum("coin", "coin2","coin3", "key", "slime", "slime2")
var treasure_type: String = "coin"
@export var treasure_icon: Texture
@onready var sprite = $Sprite2D

var icon_dict = {
	"coin": preload("res://coin.tscn"),
	"coin2": preload("res://coin.tscn"),
	"coin3": preload("res://coin.tscn"),
	"key": preload("res://key.tscn"),
	"slime": preload("res://scenes/slime.tscn"),
	"slime2": preload("res://scenes/slime.tscn")
	}

func _ready() -> void:
	random()
	randomize()
	if treasure_type in icon_dict and treasure_icon == null:
		treasure_icon = icon_dict[treasure_type]
	
	if sprite and treasure_icon:
		sprite.texture = icon_dict[treasure_type]
		
func random():
	var keys = icon_dict.keys()
	var random_index = randi() % keys.size()
	treasure_type = keys[random_index]
	treasure_icon = icon_dict[treasure_type]
	print(random_index)
	if sprite and treasure_icon:
		sprite.texture = icon_dict[treasure_type]
	
