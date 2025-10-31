extends AnimationPlayer

func play_idle_animation():
	%PlayerAnimations.play("idle")


func play_walk_animation():
	%PlayerAnimations.play("walk")
	
func play_idle_hurt():
	%PlayerAnimations.play("idle_damage")
	%PlayerAnimations.queue("idle")
	
func play_walk_hurt():
	%PlayerAnimations.play("walk_damage")
	%PlayerAnimations.queue("walk")
	
