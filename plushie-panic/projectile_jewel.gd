extends Weapon
class_name Projectile_Jewel
#borriwng projectile_shot for now
var evolved : bool = false #to track if weapon has evolved

func shoot(source, target, scene_tree):
	if target == null:
		return
		
	var projectile = projectile_node.instantiate()
	
	#setting projectile properties
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = (target.position - source.position).normalized()
	
	#adding to scene tree
	scene_tree.current_scene.add_child(projectile)
	
#for evolved Triple Needle to shoot at different angles compared to regular needle shot	
func shoot_at_angle(source, base_direction: Vector2, angle_offset: float, scene_tree):
	var projectile = projectile_node.instantiate()
	var rotated_direction = base_direction.rotated(angle_offset)
	
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = rotated_direction
	
	scene_tree.current_scene.add_child(projectile)

#override the activate func and call shoot
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
	
	#for Triple needle
	if is_evolved():

		var base_direction = (target.position - source.position).normalized()
		shoot_at_angle(source, base_direction, deg_to_rad(30), scene_tree)
		shoot_at_angle(source, base_direction, deg_to_rad(-30), scene_tree)


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
