extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const loc = Vector2()
const max_trash = 10
var player

var trash = [
	# TODO: add preloads for trash scenes here
	preload("res://resources/Trash.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_viewport().size
	randomize()
	var spawn = randi() % 100 + 1
	var number_of_trash = get_child_count()
	if(spawn == 1 && number_of_trash < max_trash):
		var x = randi() % trash.size()
		loc.x = rand_range(1, window_size.x)
		loc.y = rand_range(1, window_size.y)
		var trash_obj = trash[x].instance()
		trash_obj.position = loc
		player.connect('hit_trash', trash_obj, 'delete_trash')
		add_child(trash_obj)

