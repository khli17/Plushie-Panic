extends Weapon
class_name Circular

@export var angular_speed = 20
@export var radius = 20
@export var amount = 1

var projectile_reference : Array = []
var angle : float

@export var jewel_scenes : Array[PackedScene]=[
	preload("res://Weapons/Necklace/diamond.tscn"),
	preload("res://Weapons/Necklace/red_jewel.tscn"),
	preload("res://Weapons/Necklace/purple_jewel.tscn")
]

var initialized = false

func activate(source, _target, _scene_tree):
	if not initialized: 
		reset()
		for i in range(amount):
			add_to_player(source)
		initialized = true

func add_to_player(source):
	var jewel_index = projectile_reference.size() % jewel_scenes.size()
	
	var projectile = jewel_scenes[jewel_index].instantiate()
	
	projectile.speed = 0
	projectile.damage = damage
	projectile.source = source
	#projectile.hide()
	
	projectile_reference.append(projectile)
	source.call_deferred("add_child", projectile)

func update(delta):
	angle += angular_speed * delta
	
	for i in range(projectile_reference.size()):
		var offset = i * (360.0/amount)
		
		projectile_reference[i].position = radius * Vector2(cos(deg_to_rad(angle+offset)), sin(deg_to_rad(angle+offset)))
		
		#projectile_reference[i].show()
	
func reset():
	for projectile in projectile_reference:
		if is_instance_valid(projectile):
			projectile.queue_free()
	projectile_reference.clear()

func upgrade_item():
	if max_level_reached():
		reset()
		slot.item = evolution
		slot.item.initialized = false
		slot.item.reset()
		return
		
	if not is_upgradeable():
		return
		
	var upgrade = upgrades[level -1]
	var old_amount = amount
	
	angular_speed += upgrade.angular_speed
	amount += upgrade.amount
	damage += upgrade.damage
	
	level += 1
	
	if initialized:
		var extra = amount - old_amount
		for i in range(extra):
			add_to_player(projectile_reference[0].source)
	
	
