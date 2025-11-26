extends Resource

class_name Item

@export var title : String
@export var texture : Texture2D
var level = 1

#abstract func to keep a track
func upgrade_item():
	pass
