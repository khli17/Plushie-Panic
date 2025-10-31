extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage :float = 1


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass # Replace with function body.


func _on_screen_exited() -> void:
	pass # Replace with function body.
