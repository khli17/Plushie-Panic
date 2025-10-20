extends CharacterBody2D

#signal health_depleted

var health = 100.0
var speed = 200.0
#code from tutorial will figure out how to implement
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") #movement WASD
	velocity = direction * speed # move at direction of 600 pixels per sec
	move_and_slide()
	
	if velocity.x > 0:
		$PlayerAnimations.flip_h = false
	elif velocity.x < 0:
		$PlayerAnimations.flip_h = true
	
	##plays walk animation
	if velocity.length() > 0.0:
		##gets access to node to get the animation
		$PlayerAnimations.play_walk_animation()
	else: #plays idle animation
		%PlayerAnimations.play_idle_animation()
#
	#const DAMAGE_RATE = 5.0
	#var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	#if overlapping_mobs.size() > 0:
		#health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		#%ProgressBar.value = health
		#%ProgressBar.max_value = 500
		#if health <= 0.0:
			#health_depleted.emit()
