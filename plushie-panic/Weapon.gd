extends Resource
class_name Weapon

@export var name : String
@export var texture : Texture2D

@export var damage : float
@export var cooldown : float
@export var speed : float

@export var needle_node : PackedScene = preload("res://needle_weapon.tscn")

func activate(_source, _target, _scene_tree):
	pass
