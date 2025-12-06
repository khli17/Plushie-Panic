extends BaseEnemy

func _ready():
	super._ready()
	
	health = 500;
	damage = 15
	speed = 85
	is_boss = true
	
	%BearAnimations. play_walk()
	

#flips bunny to face player
func update_sprite_direction():
	if velocity.x > 0:
		$BearAnimations.flip_h = true
	elif velocity.x < 0:
		$BearAnimations.flip_h = false

#when enemy is hit, flashes red
func apply_damage_flash():
	var tween = get_tree().create_tween()
	tween.tween_property($BearAnimations, "modulate", Color(3, 0.25, 0.25), 0.2)
	tween.chain().tween_property($BearAnimations, "modulate", Color(1,1,1), 0.2)
	tween.bind_node(self)
