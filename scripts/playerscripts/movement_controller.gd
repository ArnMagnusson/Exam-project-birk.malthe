extends CharacterBody2D

#general stats
@export var speed = 40
@export var gold_multiplier = 0
@export var gold = 0
@export var damage = 1
@export var health = 3
@export var dash_speed = 40

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
	move_and_slide()
	
	
func attack():
	if Input.is_action_just_pressed("left_click"):
		print("slash")
		$AnimationPlayer.play("attack")

		
func death():
	pass
	
func dash():
	pass

func inventory():
	pass

func perks():
	pass
	
func player_health():
	pass

func debugkey():
	pass
