extends NinePatchRect

@onready var chest = $AnimatedSprite2D
@onready var options = %Upgrades
@onready var rewards = $Rewards

func _ready():
	randomize()
	hide()
	$Open.show()
	$Close.hide()
	
	
#when open, play idle and pause scene tree and show chest
func open():
	clear_reward() #clears prev rewards before opening
	chest.play("idle")
	get_tree().paused = true
	show()
	$Open.show()
	$Close.hide()
	


func _on_open_pressed() -> void:
	chest.play("open_chest")
	await chest.animation_finished #wait for animation to finish to set rewards
	set_reward()
	$Open.hide()
	$Close.show()


func _on_close_pressed() -> void:
	get_tree().paused = false
	hide()

func set_reward():
	clear_reward() #clears rewards before setting
	var chance = randf()
	if chance < 0.5:
		upgrade_item(1,2)
		print("rare")
	elif chance < 0.75:
		upgrade_item(0,2)
		print("epic")
	else: 
		upgrade_item(0,3)
		print("legendary")
		
func upgrade_item(start, end):
	for index in range(start, end):
		var upgrades = options.get_available_upgrades()
		
		if upgrades.size() == 0: #gives player gems when no upgrades available
			add_gems(index)
		else: #for picking a random upgrade as a reward
			var selected_upgrade : Item
			selected_upgrade = upgrades.pick_random()
			rewards.get_child(index).texture = selected_upgrade.texture
			selected_upgrade.upgrade_item()

func clear_reward():
	for slot in rewards.get_children():
		slot.texture = null
	
	
func add_gems(index):
	var gem : Gems = load("res://Items/Misc/Gem.tres")
	gem.player_reference = owner
	rewards.get_child(index).texture = gem.texture
	gem.upgrade_item()
