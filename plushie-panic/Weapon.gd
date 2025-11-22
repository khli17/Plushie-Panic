extends Item
class_name Weapon

@export var damage : float
@export var cooldown : float
@export var speed : float

@export var projectile_node : PackedScene = preload("res://Weapons/Needle/needle_weapon.tscn")

@export var upgrades : Array[Upgrade]
#for evolution
@export var item_needed : PassiveItem
@export var evolution : Weapon

var slot
var evolved : bool = false #to track if weapon has evolved

func activate(_source, _target, _scene_tree):
	pass
	
#check if weapon is upgradable	
func is_upgradeable() -> bool:
	if level <= upgrades.size():
		return true
	return false

func upgrade_item():
	if not is_upgradeable():
		return
	
	var upgrade = upgrades[level - 1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	
	level += 1
	
	evolved = true
	
func max_level_reached():
	if upgrades.size() +1 == level and upgrades.size() != 0:
		return true
	return false
	
func is_evolved() -> bool:
	return evolved
