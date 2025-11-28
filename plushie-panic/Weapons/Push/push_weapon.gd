extends Area2D

@export var player = CharacterBody2D

func _physics_process(delta):
	%PushAnimations.play_attack()
		
	if player.face_right:
		%PushAnimations.scale.x = -1
	else:
		%PushAnimations.scale.x = 1
