extends CharacterBody2D

var pos: Vector2
var rot: float
var dir : float
@export var speed = 200
@export var damage = 20

func _ready():
	global_position=pos
	#global_rotation=rot
	$Sprite2D.rotation = 0
	await get_tree().create_timer(2).timeout
	queue_free()
	
func _physics_process(delta):
	velocity=Vector2(speed, 0).rotated(dir)
	move_and_slide()
	
func _on_hitdetect_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
