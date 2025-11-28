extends AnimatedSprite2D

func play_attack():
	%PushAnimations.play("attack")

func play_attack_evo():
	%PushAnimations.play("attack_evolve")
