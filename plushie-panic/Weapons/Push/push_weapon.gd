extends Area2D

@export var player = CharacterBody2D
var damage : float = 3
var speed : float = 150
var weapon
var pushing = false

@onready var hitbox = $ColllisionShape2D

func _physics_process(delta):
	%PushAnimations.play_attack()
		
	if player.face_right:
		%PushAnimations.scale.x = -1
	else:
		%PushAnimations.scale.x = 1

func push():
	if pushing:
		return
	
	pushing = true
	
	_update_flip()
	
	hitbox.disabled = false
	
	%PushAnimations.play_attack()
	
	await %PushAnimations.play_attack().animation_finished
	
	hitbox.disabled = true
	
func _update_flip():
	if player.face_right:
		scale.x = 1
	else:
		scale.x = -1
		
func _on_area_entered(body):
	if pushing and body.has_method("take_damage"):
		body.take_damage(damage)


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
