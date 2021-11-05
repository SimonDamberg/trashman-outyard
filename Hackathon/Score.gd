extends Node

export var score = 0

signal update_score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_score(trash_value):
	score += trash_value
	emit_signal("update_score", score)

func _on_Player_hit_trash(trash_value, body):
	add_score(trash_value)

func _on_GameController_update_score(new_score):
	score = new_score

func _on_Player_update_score(new_score_player):
	score = new_score_player
	print(score)
