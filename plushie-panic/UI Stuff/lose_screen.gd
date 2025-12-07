extends CanvasLayer

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/main_menu.tscn")
	
func _on_retry_pressed() -> void:
	AudioManager.play_bg_music()
	get_tree().change_scene_to_file("res://game.tscn")
	$Lose.hide()
