extends CanvasLayer

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/main_menu.tscn")

func lose():
	get_tree().paused = false
	$Lose.show()
	AudioManager.play_lose_jingle()


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	$Lose.hide()
