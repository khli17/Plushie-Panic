extends CharacterBody2D

var health : float = 100.0:
	set(value):
		health = value
		%Health.value = value
var speed : float = 200.0
var exp : float = 0.0
var face_right : bool
var isHurt : bool = false
var nearest_enemy: CharacterBody2D
var nearest_enemy_distance : float = INF



func _physics_process(delta):
	if nearest_enemy: #if nearest_enemy is not null, sotre its separation
		nearest_enemy_distance = nearest_enemy.separation
	else: #set default value
		nearest_enemy_distance = INF
		
	#for movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") #movement WASD or keys
	velocity = direction * speed # move at direction of 600 pixels per sec
	move_and_slide()
	
	#flips player to face correct direction
	if velocity.x > 0:
		$Player2DAnimation.flip_h = false
		face_right = false
	elif velocity.x < 0:
		$Player2DAnimation.flip_h = true
		face_right = true
		
	if isHurt:
		return
	
	##plays walk animation
	if velocity.length() > 0.0:
		##gets access to node to get the animation
		%PlayerAnimations.play_walk_animation()
		
	else: #plays idle animation
		%PlayerAnimations.play_idle_animation()
		
func take_damage(amount):
	health-=amount
	isHurt = true
	if velocity.length() > 0.0:
		%PlayerAnimations.play_walk_hurt()
	else: 
		%PlayerAnimations.play_idle_hurt()
	#timer to make sure hurt animaitons dont play for too long
	get_tree().create_timer(0.5).timeout.connect(func(): isHurt = false)

	print(amount)
##when enemy touches damage hitbox
func _on_hit_box_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
	
