extends Node

@onready var menu_music = preload("res://Audio/Happy.wav")
@onready var bg_music = preload("res://Audio/Forest.wav")
@onready var win_jingle = preload("res://Audio/Win Stinger 2.wav")
@onready var lose_jingle = preload("res://Audio/Lose Stinger 1.wav")

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	sfx_player = AudioStreamPlayer.new()
	
	add_child(music_player)
	add_child(sfx_player)

	music_player.set_process_mode(Node.PROCESS_MODE_ALWAYS)
	sfx_player.set_process_mode(Node.PROCESS_MODE_ALWAYS)

func play_music(stream):
	music_player.stop()
	music_player.stream = stream
	music_player.play()

func play_sfx(stream):
	sfx_player.stream = stream
	sfx_player.play()

func play_menu_music():
	play_music(menu_music)

func play_bg_music():
	play_music(bg_music)

func play_win_jingle():
	play_sfx(win_jingle)

func play_lose_jingle():
	play_sfx(lose_jingle)
