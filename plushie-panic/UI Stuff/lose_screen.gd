extends CanvasLayer

func _ready():
	lose()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/main_menu.tscn")

func lose():
	get_tree().paused = false
	$Lose.show()
	


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	$Lose.hide()
