extends CharacterBody2D

#variables for damage, health, speed & gold + player variables
@export var damage = 1
@export var health = 5
@export var speed = 35
@export var gold_reward = 2
var player = null
@onready var character_body_2d: CharacterBody2D = $"slime"
var pickup = preload("res://scenes/base_pickup/Base_pickup.tscn")

#movement script
func _physics_process(delta):
	#checks if there is a player to chase
	if player:
		#determines direction based on players position and slimes position, normalized() makes it into a vector
		var direction = (player.global_position - global_position).normalized()
		#sets velocity equal to direction * movement speed to determine where and how fast the slime goes
		velocity = direction * speed
		#walk animation
		$AnimationPlayer.play("slime_walk")
		move_and_slide()
		

#determine player when they enter detection_area
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body

#redetermine player when they leave detection_area
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null

#slime take damage and die function
func take_damage(damage_ammount):
	print("damage taken", health)
	health -=damage_ammount
	if health <= 0:
		Economy.Gold_dropped(gold_reward)
		death()

#death function, removes slime & death animation
func death():
	$Sprite2D.hide()
	$TextureRect.visible = true
	player = null
	await get_tree().create_timer(0.5).timeout
	damage = 0
	$CollisionShape2D.hide()
	var pickup_instance = pickup.instantiate()
	self.add_child(pickup_instance)
	await get_tree().create_timer(0.5).timeout
	queue_free()


#slime deal damage function
func _on_attack_detection_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		player = null
		await get_tree().create_timer(0.5).timeout
		player = body


	
