extends CharacterBody2D

var health = 3
var damage = 2
var speed = 50.0
var isDamage : bool = false
var knockback : Vector2
var separation : float

#makes sure nodes/children are created
@onready var player = get_node("/root/Game/Player")

func _ready():
	%BunnyAnimations.play_walk()


# moves enemy towards player
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	#flips bunny to face player
	if velocity.x > 0:
		$BunnyAnimations.flip_h = true
	elif velocity.x < 0:
		$BunnyAnimations.flip_h = false
	#calls separation + knockback
	check_separation(delta)
	knockback_update(delta)
		
	#if separation is more than 500 from player, despawn enemies
func check_separation(_delta):
	separation = (player.position - player.position).length()
	if separation >= 500:
		queue_free()
	
	#if any enemy is near, update nearest enemy from enemy to player
	if separation < player.nearest_enemy_distance: 
		player.nearest_enemy = self

#knockback to prevent enemies from toppling each other
func knockback_update(delta):
	velocity = (player.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50

#enemy takes damage
func take_damage(amount):
	health -= amount
	$BunnyAnimations.material = load("res://Shaders/damagaeflash.tres")
	if health == 0:
		queue_free()
		
		#const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		#var smoke = SMOKE_SCENE.instantiate()
		#get_parent().add_child(smoke)
		#smoke.global_position = global_position 
