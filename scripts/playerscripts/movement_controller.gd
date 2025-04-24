extends CharacterBody2D

#region inspector stuff, like onready, var
@onready var enemyhit = $Enemyhit
#stats
@export var health = 100
@export var max_health = 100

#general stats
@export var speed = 60
@export var speed_boost = 1
@export var dash_speed = 40
@export var LungeDMG = 30
@export var SlashDMG = 15

#Animation
@onready var VFXL = $"VFX container/VFXLunge"
@onready var VFXS = $"VFX container/VFXslash"

#attack stuff
var attacking = false
@onready var LungeDetect = $WeaponDetection/Lungedetection/lungedetectionshape
@onready var SlashDetect = $WeaponDetection/slashdetection/slashdetectioncolish
@onready var hud = $HUD
@export var damage_taken = false

#endregion

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	VFXL.hide()
	VFXS.hide()
	LungeDetect.set_deferred("disabled", true)
	SlashDetect.set_deferred("disabled", true)
	$HUD.updatehealthbar(health, max_health)
	
func _process(delta):
	attack()
	debugkey()
	#Directions, left, right, up and down
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
#region movement animation
	if attacking == false: #hvis attacking er false, movement unlocked.
		velocity = direction * speed * speed_boost
		if direction.length() > 0:
			var facing_left = direction.x < 0
			$Sprite2D.flip_h = facing_left #main sprite
			VFXL.flip_h = facing_left #lunge
			VFXS.flip_h = facing_left #slash
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
			speed = 60 * speed_boost
	move_and_slide()
#endregion
#collision rotation manage code
	if Input.is_action_pressed("left"):
		LungeDetect.position.x = -32
	if  Input.is_action_just_pressed("right"):
		LungeDetect.position.x = 32

#region attack animation region
func attack():
	if Input.is_action_just_pressed("left_click"):
		print("slash")
		speed = 0 #change at somepoint
		$AnimationPlayer.play("attack")
		attacking = true
	
	if $AnimationPlayer.current_animation != "attack":
		speed = 60
		attacking = false
		LungeDetect.set_deferred("disabled", true)
		SlashDetect.set_deferred("disabled", true)
#endregion

func death():
	print("dead")
	queue_free()
	
func powerups(power_type: String):
	match power_type:
		"speed boost":
			speed_boost = 1.2
			print(speed_boost)
		"health up":
			if health < 80: #change later
				health += 20 #basically regen
				hud.updatehealthbar(health, max_health) #updates healthbar
		"strength":
			Playerstats.strength *=1.2 #increaser strength aka damage.
		"gold up":
			Playerstats.gold_multiplier += 1 #Double coins
		"fortitude":
			Playerstats.fortitude += 3 #increase fortitude
	print(power_type)
	
#My debug function for key. I love it.
func debugkey():
	if Input.is_action_just_pressed("debug"):
		print(attacking) 
		print(speed_boost)
		print(Economy.gold, "GOLD")

#region Dealdamage/takedamage/heal
#damage function
func take_damage(damage_amount): #callet af fjender
	damage_amount -= Playerstats.fortitude*2
	damage_taken = true
	passiveheal()
	health -= damage_amount #-health med damage
	print("Damage taken") #Printer damage taken
	hud.updatehealthbar(health, max_health) #kalder update function i Hud
	if health <= 0: #hvis health er mindre end 0 og er 0 kalder death function.
		death()
	
func Health():#healthregen
	var target_health = max_health #target health
	var heal_speed = 10 #heal speed how much hp heal every frame
	while damage_taken == false and health < max_health: #loop
		health += heal_speed  * 0.02 #0.02 is to spread it out over frames so its not just instant heal
		hud.updatehealthbar(health, max_health) #update hud
		await get_tree().create_timer(0.02).timeout #another smooth
		if health == max_health: #if health is max heath stop loopw
			break

func passiveheal():#stops health regen
	if damage_taken == true: #set damage_taken to true, and stop while in health func
		$healtimer.start(5) #starts 5 second timer
		await  $healtimer.timeout #awaiting timer stop
		damage_taken = false #damage_taken false
		await Health() #begin the healing
		
#lunge and slash detection
func _on_lungedetection_body_entered(body):
	print("body detected") #Prints if body is detected
	if body.has_method("take_damage"): #checks if body has take_damage function
		body.take_damage(LungeDMG+Playerstats.strength*2) #calls take_damage function. PS you can do this, wish i knew sooner.
#check notes above
func _on_slashdetection_body_entered(body):
	print("body detected")
	if body.has_method("take_damage"):
		body.take_damage(SlashDMG+Playerstats.strength*2)
#endregion
