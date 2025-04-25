extends CharacterBody2D

#variables for damage, health, speed & gold + player variables
@export var damage = 10
@export var health = 30
@export var speed = 70
@export var gold_reward = 30
var player = null
var can_attack = false #can attack player
@onready var character_body_2d: CharacterBody2D = $"ghost."

func _ready():
	#get_tree().get_root().get_node("Mainnode").register_enemy() #register enemy
	pass
#movement script
func _physics_process(delta):
	#checks if there is a player to chase
	if player:
		#determines direction based on players position and slimes position, normalized() makes it into a vector
		var direction = (player.global_position - global_position).normalized()
		#sets velocity equal to direction * movement speed to determine where and how fast the slime goes
		velocity = direction * speed
		#walk animation
		$AnimationPlayer.play("ghost_walk")
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
		death()

#death function, removes slime & death animation
func death():
	Economy.Gold_dropped(gold_reward*Playerstats.gold_multiplier)
	$Sprite2D.hide()
	$TextureRect.visible = true
	player = null
	#get_tree().get_root().get_node("Mainnode").unregister_enemy()
	await get_tree().create_timer(0.5).timeout
	queue_free()

#slime deal damage function
func _on_attack_detection_body_entered(body: Node2D) -> void:
	can_attack = true
	while  player == body and can_attack == true: #chekker om player er body og om den kan attack
		if body.has_method("take_damage"):
			body.take_damage(damage)
			player = null
			if body == null or !body.is_inside_tree():
				break
			await get_tree().create_timer(0.5).timeout
			player = body

func _on_attack_detection_body_exited(body):
	can_attack = false #on area exit sætter attack til false
