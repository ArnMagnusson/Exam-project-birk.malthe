extends CharacterBody2D

@export var speed = 20
@export var gold_multiplier = 0
@export var gold = 0
@export var damage = 1
@export var health = 3
@export var dash_speed = 40

func _ready():
	pass
	
func _process(delta):
	var direction = Input.get_axis("left", "right") #venstre - value højre + value
	var vertical_direction = Input.get_axis("up", "down")
	attack()
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	
func attack():
	if Input.is_action_just_pressed("left_click"):
		print("slash")
		$james.play("slash")  # Play the slash animation
		$james/jamesvfx.play("lunge")  # Play the lunge VFX animation
		$james/jamesvfx.show()  # Make sure the VFX is visible

		
func death():
	pass
	
func dash():
	pass

func inventory():
	pass

func perks():
	pass

func debugkey():
	pass
