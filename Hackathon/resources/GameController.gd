extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const window_size = Vector2(1024,600)
const loc = Vector2()

var trash = [
	# TODO: add preloads for trash scenes here
	preload("res://resources/Trash.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize()
	var spawn = randi() % 100 + 1
	if(spawn == 1):
		var x = randi() % trash.size()
		loc.x = rand_range(1, window_size.x)
		loc.y = rand_range(1, window_size.y)
		var scene = trash[x].instance()
		scene.position = loc
		add_child(scene)
