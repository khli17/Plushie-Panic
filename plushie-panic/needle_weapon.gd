extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage :float = 1

func _physics_process(delta):
	position += direction * speed * delta

#calls take_damage function if the interacting body has one
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

#when needle goes offstream, removes it
func _on_screen_exited() -> void:
	queue_free()
