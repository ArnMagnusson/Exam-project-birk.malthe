extends Node2D

@export_enum("coin", "coin2","coin3", "key", "slime", "ghost")
var treasure_type: String = "coin"
@export var treasure_icon: PackedScene
@onready var sprite = $Sprite2D
var random_index = null

@export var icon_dict = {
	"coin": preload("res://coin.tscn"),
	"coin2": preload("res://coin.tscn"),
	"coin3": preload("res://coin.tscn"),
	"key": preload("res://key.tscn"),
	"slime": preload("res://scenes/slime.tscn"),
	"ghost": preload("res://ghost.tscn")
	}

func _ready() -> void:
	if treasure_type in icon_dict and treasure_icon == null:
		treasure_icon = icon_dict[treasure_type]
	
	if sprite and treasure_icon:
		sprite.texture = icon_dict[treasure_type]
		
func random():
	var keys = icon_dict.keys()
	random_index = randi() % keys.size()
	print(random_index)
	icon_dict.erase(random_index)
	
#itemspawn, had to make a bunch of if statements otherwise it would spawn everything for some reason
func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		random()
		randomize()
		#if number picked is 0 spawn coin
		if random_index == 0:
			var coinscene = preload("res://coin.tscn")
			var instance = coinscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		#if number picked is 1 spawn coin
		if random_index == 1:
			var coinscene = preload("res://coin.tscn")
			var instance = coinscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		#if number picked is 2 spawn coin
		if random_index == 2:
			var coinscene = preload("res://coin.tscn")
			var instance = coinscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		#if number is 3 spawn key
		if random_index == 3:
			var keyscene = preload("res://key.tscn")
			var instance = keyscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		#if number is 4 spawn enemy
		if random_index == 4:
			var enemyscene = preload("res://scenes/slime.tscn")
			var instance = enemyscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		#if number is 5 spawn enemy
		if random_index == 5:
			var enemyscene = preload("res://ghost.tscn")
			var instance = enemyscene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)

			
