extends CharacterBody2D

#region inspector stuff, like onready, var
@onready var enemyhit = $Enemyhit

#general stats
@export var speed = 60
@export var gold = 0
@export var dash_speed = 40
@export var LungeDMG = 3
@export var SlashDMG = 1

#stats
@export var fortitude = 1
@export var strength = 1
@export var constitution = 1
@export var health = 3
@export var max_health = 3
@export var gold_multiplier = 0

#Animation
@onready var VFXL = $"VFX container/VFXLunge"
@onready var VFXS = $"VFX container/VFXslash"

#attack stuff
var attacking = false
@onready var LungeDetect = $WeaponDetection/Lungedetection/lungedetectionshape
@onready var SlashDetect = $WeaponDetection/slashdetection/slashdetectioncolish
@onready var hud = $HUD
#endregion

func _ready():
	VFXL.hide()
	VFXS.hide()
	LungeDetect.set_deferred("disabled", true)
	SlashDetect.set_deferred("disabled", true)
	$HUD.updatehealthbar(health, max_health)
func _process(delta):
	player_health()
	attack()
	debugkey()
	
	#Directions, left, right, up and down
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
#region movement animation
	if attacking == false: #hvis attacking er false, movement unlocked.
		velocity = direction * speed
		if direction.length() > 0:
			var facing_left = direction.x < 0
			$Sprite2D.flip_h = facing_left
			VFXL.flip_h = facing_left
			VFXS.flip_h = facing_left
			$AnimationPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if direction.length() == 0 and $AnimationPlayer.current_animation != "attack":
		$AnimationPlayer.play("idle") #spiller idle, hvis man ikke bevæger sig og animation ikke er attack

	if attacking == true: #locks movement when attacking
		velocity = Vector2(0, 0)
		speed = 0
	else:
		if attacking == false: #unlocks movement when not attacking
			speed = 40
	move_and_slide()
	
#endregion
	
#region attack animation region
func attack():
	if Input.is_action_just_pressed("left_click"):
		print("slash")
		speed = 0
		$AnimationPlayer.play("attack")
		attacking = true
	
	if $AnimationPlayer.current_animation != "attack":
		speed = 40
		attacking = false
		LungeDetect.set_deferred("disabled", true)
		SlashDetect.set_deferred("disabled", true)
#endregion

func death():
	print("dead")
	queue_free()
	
func dash():
	pass

func powerups(power_type: String):
	match power_type:
		"speed boost":
			speed *= 1.5
		"health up":
			health = 3 #basically regen
		"strength":
			strength *=1.2 #increaser strength aka damage.
		"gold up":
			gold_multiplier *= 2 #Double coins
		"fortitude":
			fortitude += 3 #increase fortitude ikke implementeret endnu i selve koden.
	
func player_health():
	pass
	
#My debug function for key. I love it.
func debugkey():
	if Input.is_action_just_pressed("debug"):
		print(attacking) 
		
#region Dealdamage/takedamage

#damage function
func take_damage(damage_amount): #callet af fjender
	health -= damage_amount #-health med damage
	print("Damage taken") #Printer damage taken
	hud.updatehealthbar(health, max_health) #kalder update function i Hud
	if health <= 0: #hvis health er mindre end 0 og er 0 kalder death function.
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
#endregion
