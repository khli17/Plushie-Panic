extends AnimatedSprite2D

func play_attack():
	%PushAnimations.play("attack")

func play_attack_evo():
	scale = Vector2(2,2)
	%PushAnimations.play("attack_evolve")
