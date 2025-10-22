extends Area2D

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	%PushAnimations.play_attack_animation()
		
	if player.face_right:
		%PushAnimations.scale.x = -1
	else:
		%PushAnimations.scale.x = 1
