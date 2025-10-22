class_name WeaponManager
extends Node

@export var weapon_name : StringName
@export var weapon_level : int
@export var weapon_damage : float
@export var weapon_speed : float
@export var weapon_knockback : float
@export var weapon_size : float
@export var weapon_cooldown : float
@export var can_use : bool

func weapon_active():
	can_use = true
	
