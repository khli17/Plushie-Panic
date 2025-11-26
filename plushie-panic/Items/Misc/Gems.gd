extends Item
class_name Gems

var player_reference : CharacterBody2D

@export var gems : int = 5

func upgrade_item():
	if is_instance_valid(player_reference):
		player_reference.gain_gems(gems)
