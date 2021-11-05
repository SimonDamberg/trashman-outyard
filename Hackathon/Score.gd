extends Node

export var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_score(trash_value):
	score += trash_value
	print("Hit detected! Adding %d" % trash_value)
	print("New score: %d" % score)

func _on_Player_hit_trash(trash_value, body):
	add_score(trash_value)
