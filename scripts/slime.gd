extends CharacterBody2D

#variables for damage, health, speed & gold + player variables
@export var damage = 1
@export var health = 1
@export var speed = 35
@export var gold = 2
var player = null

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
