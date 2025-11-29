extends BaseEnemy

func _ready():
	health = 10;
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

#when enemy is hit, flashes red
func apply_damage_flash():
	var tween = get_tree().create_tween()
	tween.tween_property($BunnyAnimations, "modulate", Color(3, 0.25, 0.25), 0.2)
	tween.chain().tween_property($BunnyAnimations, "modulate", Color(1,1,1), 0.2)
	tween.bind_node(self)
