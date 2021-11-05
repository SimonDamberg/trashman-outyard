extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 1
var textures = ['chugjug.png','cigg.png','cock.png']
var trash = Sprite.new()
var texturesLoaded = [preload('res://assets/chugjug.png'),preload('res://assets/cigg.png'),preload('res://assets/cock.png'),]
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(trash, true)
	trash.texture = texturesLoaded[(rand_range(0,len(texturesLoaded)))]
	pass # Replace with function body.

func delete_trash(trash_value, body):
	get_parent().get_node(body.name).queue_free()
