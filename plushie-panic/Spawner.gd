extends Node2D

@export var player : CharacterBody2D
@export var bunny: PackedScene
@export var cat: PackedScene
@export var rat: PackedScene
@export var dog: PackedScene
@export var Boss: PackedScene

var enemy_waves = []

var distance : float = 400
var can_spawn : bool = true

var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)
		
var second : int: 
	set(value):
		second = value
		if second >= 60:
			second -= 60
			minute += 1
		%Second.text = str(second).lpad(2,'0')
		
func _ready():
	enemy_waves = [
	{"time": 0, "scenes": [rat]},
	{"time": 60, "scenes": [rat, bunny]},
	{"time": 90, "scenes": [bunny, cat]},
	{"time": 120, "scenes": [cat, dog]},
	{"time": 180, "scenes": [rat, dog]},
	{"time": 240, "scenes": [rat, bunny, cat, dog]}
	
]
			
##for optimizing so spawner only spawns when blank amount of enemies 
func _physics_process(delta):
	if get_tree().get_node_count_in_group("Enemy") < 500:
		can_spawn = true
	else:
		can_spawn = false
	


func spawn(position : Vector2, elite : bool = false):
	if not can_spawn:
		return
		
	#var enemy_instance = bunny.instantiate() #bunny
	#if certain amount of time goes by, spawn certain enemies
	var scene  := get_enemy_type_for_time()
	
	var enemy_instance = scene.instantiate()
	
	enemy_instance.position = position
	enemy_instance.elite = elite
	
	get_tree().current_scene.add_child(enemy_instance)
	
#determines what enemmies to spawn depending on time
func get_enemy_type_for_time() -> PackedScene:
	var total_seconds = minute * 60 + second
	
	var available : Array = []
	var last_wave_scenes : Array = []
	
	for wave in enemy_waves:
		if total_seconds >= wave["time"]:
			last_wave_scenes = wave["scenes"]
		else:
			break
			
	#after last wave, randomize everything
	if last_wave_scenes.is_empty():
		return rat
		
	return last_wave_scenes.pick_random()
	
func get_random_position() -> Vector2: 
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0,2*PI))
	
func amount(number: int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout():
	second += 1
	amount(1)


func _on_pattern_timeout():
	for i in range(5):
		spawn(get_random_position())


func _on_boss_timeout() -> void:
	if minute >= 10:
		var boss_instance = Boss.instantiate()
		boss_instance.position = get_random_position()
		get_tree().current_scene.add_child(boss_instance)
		
		can_spawn = false
		


func _on_elite_timeout() -> void:
	spawn(get_random_position(), true)
