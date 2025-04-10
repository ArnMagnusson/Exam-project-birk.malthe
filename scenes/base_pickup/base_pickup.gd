extends Node2D

#Type
@export_enum("speed boost", "gold up", "health up", "strength", "fortitude") #drop down
var power_type: String = "speed boost" #default is speed boost
@export var power_icon: Texture

@onready var sprite = $Sprite2D


#Icon dictionary for de forskellige power up textures
var icon_dict = {
	"speed boost": preload("res://powerups textures/movementspeedup.png"),
	"gold up": preload("res://powerups textures/goldup.png"),
	"health up": preload("res://powerups textures/healthup.png"),
	"strength": preload("res://powerups textures/strup.png"),
	"fortitude": preload("res://powerups textures/forup.png")
	}
	
func _ready():
	randomize()
	var probability : int = 10
	if (randi() % probability) == (probability - 1):
		random_drop()
		
		#hvis der ikke er valgt en power icon i inspector sæt power_icon til icon_dict[power_type]
		#Specifikke texture eksempel strengthup valgt i inspectoren ingen manuelt sat texture. 
		#Giver strength up texture automatisk
	if power_type in icon_dict and power_icon == null:
		power_icon = icon_dict[power_type]
		
	#sætter sprite texture til power typen i icon_dict, så sprite ændrer texture
	if sprite and power_icon:
		sprite.texture = icon_dict[power_type]
		
#function. Hvis body er Player, og har method power ups. kalder den på powerups function i player
#og derefter fjerner sig selv med queue_free
func _on_pickup_area_body_entered(body):
	if body.is_in_group("Player") and body.has_method("powerups"):
		print("BOOST")
		body.powerups(power_type)
		queue_free()

func random_drop():
	var power_ups = ["speed boost", "gold up", "health up", "strength", "fortitude"]
	if power_ups.size() > 0:
		var idx : int = randi() % power_ups.size()
		var power_up = power_ups[idx]
		power_type = power_up
		
	
