extends BaseEnemy

func _ready():
	health = 5;
	damage = 2
	speed = 60
	%RatAnimations.play_walk()
	super._ready()

#flips bunny to face player
func update_sprite_direction():
	if velocity.x > 0:
		$RatAnimations.flip_h = false
	elif velocity.x < 0:
		$RatAnimations.flip_h = true

#when enemy is hit, flashes red
func apply_damage_flash():
	var tween = get_tree().create_tween()
	tween.tween_property($RatAnimations, "modulate", Color(3, 0.25, 0.25), 0.2)
	tween.chain().tween_property($RatAnimations, "modulate", Color(1,1,1), 0.2)
	tween.bind_node(self)
