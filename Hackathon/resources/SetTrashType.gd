extends Node

var value
var trash_type
var value_map = {
	'chugjug': 3,
	'cigg': 5,
	'cock': 1}
var texture_map = {
	'chugjug': preload('res://assets/chugjug.png'),
	'cigg': preload('res://assets/cigg.png'),
	'cock': preload('res://assets/cock.png')
}
var trash = Sprite.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rand = randi() % 100 + 1
	if(rand < 10): 
		# 10% spawn chance
		trash_type = 'cigg'
	elif(rand < 40):
		# 30% spawn chance
		trash_type = 'chugjug'
	else:
		# 60% spawn chance
		trash_type = 'cock'
	set_meta('type','trash')
	add_child(trash, true)
	trash.texture = texture_map[trash_type]
	value = value_map[trash_type]

func delete_trash(trash_value, body):
	get_parent().get_node(body.name).queue_free()


func _on_Area2D_body_entered(body):
	if(body.get_collision_layer() == 4):
		get_parent().get_node(self.name).queue_free()
