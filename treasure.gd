extends Node2D

@export_enum("coin", "coin2","coin3", "key", "slime", "ghost")
var treasure_type: String = "coin"
@export var treasure_icon: PackedScene
@onready var sprite = $Sprite2D
var random_index = null

func _ready() -> void:
	if treasure_type in LootManager.icon_dict and treasure_icon == null:
		treasure_icon = LootManager.icon_dict[treasure_type]
	
	if sprite and treasure_icon:
		sprite.texture = LootManager.icon_dict[treasure_type]
		
func random():
	var keys = LootManager.icon_dict.keys()
	if keys.size() == 0:
		return null
		
	random_index = randi() % keys.size()
	var random_key = keys[random_index]
	print(random_key)
	var scene = LootManager.icon_dict[random_key]
	LootManager.icon_dict.erase(random_key)
	print("Loot left: %s" % LootManager.icon_dict)
	return scene
	
#itemspawn
func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		randomize()
		var scene = random()
		if scene == null:
			print("No more loot!")
			return
		
		if scene:
			var instance = scene.instantiate()
			instance.global_position = global_position
			get_parent().add_child(instance)
		await get_tree().create_timer(1).timeout
		queue_free()
