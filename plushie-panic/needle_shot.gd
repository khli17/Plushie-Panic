extends Weapon
class_name NeedleShot

func shoot(source, target, scene_tree):
	if target == null:
		return
		
	var needle = needle_node.instantiate()
	
	#setting needle properties
	needle.position = source.position
	needle.damage = damage
	needle.speed = speed
	needle.direction = (target.position - source.position).normalized()
	
	#adding to scene tree
	scene_tree.current_scene.add_child(needle)

#override the activate func and call shoot
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
