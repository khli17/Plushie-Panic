extends CharacterBody2D

var health : float = 100.0:
	set(value):
		health = max(value, 0)
		%Health.value = value
var movement_speed : float = 200.0
var max_health : float = 100 : 
	set(value): 
		max_health = value
		%Health.max_value = value
var recovery : float = 0
var armor : float = 0
var might : float = 1.0
var area : float = 50
var magnet : float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 5 + value
var growth : float = 1

var face_right : bool
var isHurt : bool = false
var nearest_enemy: CharacterBody2D
var nearest_enemy_distance : float = 150 + area

var gems : int = 0:
	set(value):
		gems = value
		%Gems.text = "Gems: " + str(value)
		
var EXP : int = 0:
	set(value):
		EXP = value
		%EXP.value = value
var total_EXP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv. " + str(value)
		%Upgrades.show_option()
		
		#for changing xp needed depending on level
		if level >= 3:
			%EXP.max_value = 20
		elif level >= 7:
			%EXP.max_value = 40

func _physics_process(delta):
	if is_instance_valid(nearest_enemy): #if nearest_enemy is not null, sotre its separation
		nearest_enemy_distance = nearest_enemy.separation
	else: #set default value
		nearest_enemy_distance = 150 * area
		nearest_enemy = null
	#for movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") #movement WASD or keys
	velocity = direction * movement_speed # move at direction of 600 pixels per sec
	move_and_slide()
	check_EXP()
	health += recovery * delta #increase health with recovery * delta
	
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
	health-= max(amount - armor, 0)
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
	
#exp function
func gain_EXP(amount):
	EXP += amount * growth
	total_EXP += amount * growth
	
#check EXp and increase level
func check_EXP():
	if EXP > %EXP.max_value:
		EXP -= %EXP.max_value
		level += 1


func _on_magnet_area_entered(area):
	if area.has_method("follow"):
		area.follow(self)

func gain_gems(amount):
	gems += amount
	
func open_chest():
	$UI/Chest.open() 
