extends VBoxContainer

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
var UpgradeSlot = preload("res://upgrade_slot.tscn")

@export var panel : NinePatchRect

func _ready():
	hide()
	panel.hide()
	
func close_option():
	hide()
	panel.hide()
	get_tree().paused = false

#function to extract resource from slot present in container
func get_available_resource_in(items)-> Array[Item]:
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources
	
#add upgrade option with item resource	
func ad_option(item) -> int:
	if item.is_upgradeable():
		var option_slot = UpgradeSlot.instantiate()
		option_slot.item = item
		add_child(option_slot)
		return 1
	return 0

#traverse through weapons and store available weapon resource	
func get_available_weapons():
	var weapon_resource = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	return weapon_resource

	
func show_option():
	var weapons_available = get_available_weapons()
	if weapons_available.size() == 0:
		return
		
	for slot in get_children():
		slot.queue_free()	
		
	var upgrade_size = 0 #how many options are getting ded
		
	#options for every weapon available
	for weapon in weapons_available:
		if weapon.is_upgradable():
			var upgrade_slot = UpgradeSlot.instantiate()
			upgrade_slot.weapon = weapon
			add_child(upgrade_slot)
			upgrade_size += 1
			
	if upgrade_size == 0:
		return
		
	show()
	panel.show()
	get_tree().paused = true
