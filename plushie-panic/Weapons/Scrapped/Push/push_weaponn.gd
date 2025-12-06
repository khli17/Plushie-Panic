extends Weapon
class_name PushWeapon

var evolved : bool = false #to track if weapon has evolved

var push_area: Area2D
var facing_left = false

func activate(source, target, scene_tree):
	if push_area == null:
		push_area = projectile_node.instantiate()
		push_area.player = source
		push_area.damage = damage
		push_area.weapon = self
		source.add_child(push_area)
		
		push_area.position = Vector2(20,0)
		
	push_area.push()
	
	_update_direction(source)
	
func _update_direction(source):
	var direction = source.get_facing_direction()
	if direction.x <0 and not facing_left:
		facing_left = true
		push_area.scale.x = 1
	elif direction.x > 0 and facing_left:
		facing_left = false
		push_area.scale.x = -1 

#func shoot(source, target, scene_tree):
	#if target == null:
		#return
		#
	#var projectile = projectile_node.instantiate()
	#
	##setting projectile properties
	#projectile.position = source.position
	#projectile.damage = damage
	#projectile.speed = speed
	#projectile.source = source
	#projectile.direction = (target.position - source.position).normalized()
	#
	##adding to scene tree
	#scene_tree.current_scene.add_child(projectile)


func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
		
	if not is_upgradeable():
		return
	
	var upgrade = upgrades[level -1]
	damage += upgrade.damage
	
	level += 1
	
		
func is_evolved() -> bool:
	return evolved
