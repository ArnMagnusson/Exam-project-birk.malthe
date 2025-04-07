extends CharacterBody2D

@onready var enemyhit = $Enemyhit

#general stats
@export var speed = 40
@export var gold = 0
@export var dash_speed = 40
@export var LungeDMG = 3
@export var SlashDMG = 1

#stats
@export var fortitude = 1
@export var strength = 1
@export var constitution = 1
@export var health = 3
@export var gold_multiplier = 0

#Animation
@onready var VFXL = $"VFX container/VFXLunge"
@onready var VFXS = $"VFX container/VFXslash"

#attack stuff
var attacking = false
@onready var LungeDetect = $WeaponDetection/Lungedetection/lungedetectionshape
@onready var SlashDetect = $WeaponDetection/slashdetection/slashdetectioncolish

func _ready():
	VFXL.hide()
	VFXS.hide()
	LungeDetect.set_deferred("disabled", true)
	SlashDetect.set_deferred("disabled", true)
func _process(delta):
	var direction = Input.get_axis("left", "right") #venstre - value højre + value
	var vertical_direction = Input.get_axis("up", "down")
	player_health()
	attack()
	debugkey()
	
	if direction:
		velocity.x = direction * speed
		if direction > 0:
			$Sprite2D.flip_h = false
			VFXL.flip_h = false
			VFXS.flip_h = false
			$AnimationPlayer.play("Run")
		elif direction < 0:
			$Sprite2D.flip_h = true
			VFXL.flip_h = true
			VFXS.flip_h = true
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
	if Input.is_action_just_pressed("left_click") and $AnimationPlayer.current_animation !="Run":
		print("slash")
		$AnimationPlayer.play("attack")
		attacking = true
	
	if $AnimationPlayer.current_animation != "attack":
		attacking = false
		LungeDetect.set_deferred("disabled", true)
		SlashDetect.set_deferred("disabled", true)
		
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
	
#My debug function for key. I love it.
func debugkey():
	if Input.is_action_just_pressed("debug"):
		print(attacking) 

#damage function
func take_damage(damage_amount):
	health -= damage_amount
	print("Damage taken")
	if health <= 0:
		death()
	
#lunge and slash detection
func _on_lungedetection_body_entered(body):
	print("body detected") #Prints if body is detected
	if body.has_method("take_damage"): #checks if body has take_damage function
		body.take_damage(LungeDMG) #calls take_damage function. PS you can do this, wish i knew sooner.
#check notes above
func _on_slashdetection_body_entered(body):
	print("body detected")
	if body.has_method("take_damage"):
		body.take_damage(SlashDMG)
