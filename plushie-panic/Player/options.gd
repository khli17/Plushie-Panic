extends VBoxContainer

@export var weapons : HBoxContainer
var UpgradeSlot = preload("res://upgrade_slot.tscn")

func _ready():
	hide()
	
func close_option():
	hide()
	get_tree().paused = false
	
func show_option():
	var upgrade_slot = UpgradeSlot.instantiate()
	add_child(upgrade_slot)
	
	show()
	get_tree().paused = true
	
