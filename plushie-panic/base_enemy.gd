extends CharacterBody2D
class_name BaseEnemy

var damage_popup_node = preload("res://damage.tscn")
var health = 3
var damage = 2
var speed = 50.0
var is_damage : bool = false
var knockback : Vector2
var separation : float
@onready var player = get_node("/root/Game/Player")

func play_walk():
	pass

func update_sprite_direction():
	pass
	
func _ready():
	play_walk()

# moves enemy towards player
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
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
	damage_popup(amount)
	if health == 0:
		queue_free()

#instantiate damage popup and add to scene tree
func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)
