extends CanvasLayer

func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	$Win.hide()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/main_menu.tscn")

func win():
	get_tree().paused = false
	$Win.show()
