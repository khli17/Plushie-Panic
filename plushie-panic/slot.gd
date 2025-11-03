extends PanelContainer


@export var weapon : Weapon: 
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		
		

func _on_cooldown_timeout() -> void:
	if weapon:
		$Cooldown.wait_time = weapon.cooldown #any upgrade/level up will update the wait time ofo the Timer (cooldown)
		weapon.activate(owner, owner.nearest_enemy, get_tree()) #with each timeout call activate from Weapon
