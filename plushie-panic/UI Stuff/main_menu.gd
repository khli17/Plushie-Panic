extends Control

func _ready():
	get_tree().paused = false
	menu()
	AudioManager.play_menu_music()

func _on_play_pressed() -> void:
	AudioManager.play_bg_music()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_how_to_play_pressed() -> void:
	how_to_play()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_credits_pressed() -> void:
	credits()

func _on_back_pressed() -> void:
	menu()

func menu():
	$Menu.show()
	$Back.hide()
	$HowToPlay.hide()
	$Credits.hide()

func how_to_play():
	$HowToPlay.show()
	$Menu.hide()
	$Credits.hide()
	$Back.show()
	
func credits():
	$Credits.show()
	$Back.show()
	$Menu.hide()
	$HowToPlay.hide()
