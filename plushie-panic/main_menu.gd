extends Control

func _ready():
	menu()

func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_how_to_play_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	pass # Replace with function body.
	
func _on_credits_pressed() -> void:
	pass # Replace with function body.


func menu():
	$Menu.show()
	$Back.hide()
	$HowToPlay.hide()

func how_to_play():
	$HowToPlay.show()
	$Menu.hide()
	$Back.show()
