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
