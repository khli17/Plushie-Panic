extends BaseEnemy

func _ready():
	health = 3
	damage = 2
	speed = 50
	%BunnyAnimations.play_walk()
	super._ready()

#flips bunny to face player
func update_sprite_direction():
	if velocity.x > 0:
		$BunnyAnimations.flip_h = true
	elif velocity.x < 0:
		$BunnyAnimations.flip_h = false
