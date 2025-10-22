extends CharacterBody2D

var health = 3
var damage = 2
var speed = 50.0

#makes sure nodes/children are created
@onready var player = get_node("/root/Game/Player")

func _ready():
	%BunnyAnimations.play_walk()


# moves enemy towards player
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if velocity.x > 0:
		$BunnyAnimations.flip_h = true
	elif velocity.x < 0:
		$BunnyAnimations.flip_h = false

#enemy takes damage
#func take_damage():
	#health -= 1
	##%.play_hurt()
	#if health == 0:
		#queue_free()
		#
		#const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		#var smoke = SMOKE_SCENE.instantiate()
		#get_parent().add_child(smoke)
		#smoke.global_position = global_position 
