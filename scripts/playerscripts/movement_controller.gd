extends CharacterBody2D

#general stats
@onready var enemyhit = $Enemyhit
@export var speed = 40
@export var gold_multiplier = 0
@export var gold = 0
@export var health = 3
@export var dash_speed = 40
@export var LungeDMG = 3
@export var SlashDMG = 1

#stats
@export var fortitude = 1
@export var strength = 1
@export var constitution = 1


func _ready():
	pass
	
func _process(delta):	
	var direction = Input.get_axis("left", "right") #venstre - value højre + value
	var vertical_direction = Input.get_axis("up", "down")
	player_health()
	attack()
	if direction:
		velocity.x = direction * speed
		if direction > 0:
			$Sprite2D.flip_h = false
			$AnimationPlayer.play("Run")
		elif direction < 0:
			$Sprite2D.flip_h = true
			$AnimationPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	if direction == 0:
		if $AnimationPlayer.current_animation != "attack":
			$AnimationPlayer.play("idle")
	move_and_slide()
	
func attack():
	if Input.is_action_just_pressed("left_click"):
		print("slash")
		$AnimationPlayer.play("attack")

func death():
	print("dead")
	queue_free()
	
func dash():
	pass

func inventory():
	pass

func perks():
	pass
	
func player_health():
	pass

func debugkey():
	pass #My debug function for key. I love it.



func _on_enemyhit_area_entered(area): #Enemy hit player
	if area.is_in_group("Enemies"): #checks if area that hit player is in group Enemies
		print("Ooff")
		if area.has_method("get_damage"):
			var damage= area.get_damage()
			#var damage_type = area.get_damage_type() If we need it further in.
			health -= damage
			Take_damage()
#damage function
func Take_damage():
	health <= 0
	print("Damage taken")
	death()
#lunge and slash detection
func _on_lungedetection_area_entered(area): #lunge
	pass

func _on_slashdetection_area_entered(area): #slash
	pass
