extends Weapon
class_name ProjectileScissor

var evolved : bool = false #to track if weapon has evolved
var direction : Vector2

func shoot(source, target, scene_tree):
		
	var projectile = projectile_node.instantiate()
	var choice = randi() % 2
	
	if choice == 1:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT
	
	#setting projectile properties
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = direction
	
	#adding to scene tree
	scene_tree.current_scene.add_child(projectile)

#for evolved scissors
func shoot_both(source, scene_tree):
	var left = projectile_node.instantiate()
	left.position = source.position
	left.damage = damage
	left.speed = speed
	left.source = source
	left.direction = Vector2.LEFT
	scene_tree.current_scene.add_child(left)
	
	var right = projectile_node.instantiate()
	right.position = source.position
	right.damage = damage
	right.speed = speed
	right.source = source
	right.direction = Vector2.RIGHT
	scene_tree.current_scene.add_child(right)

#override the activate func and call shoot
func activate(source, target, scene_tree):
	if not is_instance_valid(target):
		return
	
	if is_evolved():
		shoot_both(source, scene_tree)
	else:
		shoot(source, target, scene_tree)



func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		slot.item.evolved = true
		return
		
	if not is_upgradeable():
		return
	
	var upgrade = upgrades[level -1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	
	level += 1
	
		
func is_evolved() -> bool:
	return evolved
