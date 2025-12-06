extends CanvasLayer

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/main_menu.tscn")

func lose():
	get_tree().paused = false
	$Lose.show()
	call_deferred("_play_jingle")


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	$Lose.hide()


func _play_jingle():
	AudioManager.music_player.stop()
	AudioManager.play_lose_jingle()
