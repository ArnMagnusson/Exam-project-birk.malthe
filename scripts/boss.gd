extends CharacterBody2D


@onready var main = get_tree().get_root().get_node("node2D")
@onready var fireballpro = preload("res://scenes/fireballprotejtile.tscn")
#variables for damage, health, speed & gold + player variables
@export var damage = 30
@export var health = 50
@export var speed = 35
@export var gold_reward = 20
var player = null
var target = null
var target_located = false
var can_attack = false
var can_fire = true
@onready var character_body_2d: CharacterBody2D = $"slime"

func _ready():
	pass
	#get_tree().get_root().get_node("Mainnode").register_enemy() #register enemy
	#movement script
	
func _physics_process(delta):
	fireball()
	#checks if there is a player to chase
	if player:
		# Set the global rotation to the angle of the direction vector
		#determines direction based on players position and slimes position, normalized() makes it into a vector
		var direction = (player.global_position - global_position).normalized()
		#sets velocity equal to direction * movement speed to determine where and how fast the slime goes
		velocity = direction * speed
		move_and_slide()
	
func fireball():
	if not target or not can_fire:
		return
	
	# Rotate the raycast toward the player
	var direction = (target.global_position - global_position).normalized()
	$rayball.rotation = direction.angle()

	# Fire only if the ray hits the player
	$rayball.force_raycast_update()
	if $rayball.is_colliding():
		var collider = $rayball.get_collider()
		if collider == target: # Make sure it's the player
			can_fire = false

			# Spawn and launch the fireball
			var fireball_instance = fireballpro.instantiate()
			fireball_instance.global_position = global_position
			fireball_instance.dir = direction.angle()
			fireball_instance.rot = direction.angle()
			fireball_instance.pos = global_position

			get_parent().add_child(fireball_instance)
			# Fireball cooldown
			await get_tree().create_timer(2.0).timeout
			can_fire = true

#determine player when they enter detection_area
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	target = body
	
#redetermine player when they leave detection_area
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	target = null

#slime take damage and die function
func take_damage(damage_ammount):
	print("damage taken", health)
	health -=damage_ammount
	if health <= 0:
		death()

#death function, removes slime & death animation
func death():
	var powerupscene = preload("res://scenes/base_pickup/Base_pickup.tscn")
	var instance = powerupscene.instantiate()
	instance.global_position = global_position
	get_parent().add_child(instance)
	Economy.Gold_dropped(gold_reward)
	$Sprite2D.hide()
	player = null
	$attack_detection.set_deferred("disable_mode", true)
	#get_tree().get_root().get_node("Mainnode").unregister_enemy() #unregister enemy
	await get_tree().create_timer(0.3).timeout
	queue_free()

#slime deal damage function
func _on_attack_detection_body_entered(body: Node2D) -> void:
	can_attack = true
	while player == body and can_attack == true: #loop
		if body.has_method("take_damage"): #duck typing, does it quack like a duck its a duck
			body.take_damage(damage)
			player = null
			if body == null or !body.is_inside_tree():
				break
			await get_tree().create_timer(1).timeout #damage immunity on player time
			player = body

func _on_attack_detection_body_exited(body):
	can_attack = false
