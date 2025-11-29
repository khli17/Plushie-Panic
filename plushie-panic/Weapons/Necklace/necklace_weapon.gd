extends Area2D
#dont think this is needled but just incaseee
var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage: float = 1
var source

func _ready():
	rotation = direction.angle()
	
func _physics_process(delta):
	position += direction * speed * delta
	
#calls take_damage function if the interacting body has one
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if "might" in source:
			body.take_damage(damage * source.might)
		else:
			body.take_damage(damage)
		body.knockback = direction * 100
		
#when needle goes offstream, removes it
func _on_screen_exited() -> void:
	queue_free()
