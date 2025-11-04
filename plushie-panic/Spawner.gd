extends Node2D
class_name Enemy 

@export var player : CharacterBody2D
@export var enemy: PackedScene
@export var enemy2: PackedScene
@export var enemy3: PackedScene
@export var Boss: PackedScene

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
			
##for optimizing so spawner only spawns when blank amount of enemies 
func _physics_process(delta):
	if get_tree().get_node_count_in_group("Enemy") < 700:
		can_spawn = true
	else:
		can_spawn = false
	


func spawn(position : Vector2):
	if not can_spawn:
		return
		
		
	var enemy_instance = enemy.instantiate() #bunny
	#if certain amount of time goes by, spawn certain enemies
	
	enemy_instance.position = position
	
	get_tree().current_scene.add_child(enemy_instance)
	
## Determine which enemy to spawn based on time
#func get_enemy_type_for_time() -> PackedScene:
	#var total_seconds = minute * 60 + second
	#
	## Spawn different enemies based on elapsed time
	#if total_seconds < 30:  # First 30 seconds - only bunnies
		#return enemy
	#elif total_seconds < 60:  # 30-60 seconds - enemy2
		#return enemy2
	#elif total_seconds < 120:  # 1-2 minutes - enemy3
		#return enemy3
	#else:  # After 2 minutes - mix of enemies or harder ones
		#return enemy3  # Or randomize between types
	
func get_random_position() -> Vector2: 
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0,2*PI))
	
func amount(number: int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout():
	second += 1
	amount(second % 10)


func _on_pattern_timeout():
	for i in range(75):
		spawn(get_random_position())


func _on_boss_timeout() -> void:
	##spawn(get_random_position(), true)
	pass
