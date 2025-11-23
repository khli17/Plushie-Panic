extends NinePatchRect

@onready var chest = $AnimatedSprite2D

func _ready():
	randomize()
	hide()
	$Open.show()
	$Close.hide()
	
	open() #test
	
#when open, play idle and pause scene tree and show chest
func open():
	chest.play("idle")
	get_tree().paused = true
	show()
	$Open.show()
	$Close.hide()
	


func _on_open_pressed() -> void:
	chest.play("open_chest")


func _on_close_pressed() -> void:
	pass # Replace with function body.

func set_reward():
	var chance = randf()
	if chance < 0.5:
		print("rare")
	elif chance < 0.75:
		print("epic")
	else: 
		print("legendary")
	
