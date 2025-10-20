extends AnimatedSprite2D

func play_idle_animation():
	%PlayerAnimations.play("idle")


func play_walk_animation():
	%PlayerAnimations.play("run")
