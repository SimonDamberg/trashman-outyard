extends Node2D

const loc = Vector2()
var max_trash = 10
var spawn_rate = 1
var lastDeploy = 0
var player
signal update_score

var trash = [
	# TODO: add preloads for trash scenes here
	preload("res://resources/Trash.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	startGame()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_viewport().size
	randomize()
	var should_spawn = randi() % 100 + 1
	var number_of_trash = get_child_count()
	lastDeploy += delta;
	if(should_spawn <= spawn_rate && number_of_trash < max_trash && lastDeploy > 1):
		var x = randi() % trash.size()
		loc.x = rand_range(1, window_size.x)
		loc.y = rand_range(1, window_size.y)
		var trash_obj = trash[x].instance()
		trash_obj.position = loc
		player.connect('hit_trash', trash_obj, 'delete_trash')
		add_child(trash_obj)

		lastDeploy = 0;

func _on_HUD_buy_limit(score):
	if(score > 40):
		print("har råd med limit")
		score -= 40
		max_trash += 3
		emit_signal("update_score", score)

func upgrade_max_trash():
	max_trash += 3


func endGame():
	var query = JSON.print({'score': get_parent().get_node("Score").score})
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	get_parent().get_node("HTTPRequest").request("http://127.0.0.1:8000/score", headers, false, HTTPClient.METHOD_POST,query)
	for x in get_parent().get_node("GameOver").get_children():
		x.visible = true
	get_parent().get_node("GameTimer").stop()
func startGame():
	get_parent().get_node("GameTimer").start(120)
	get_parent().get_node("Score").score = 0
	for x in get_parent().get_node("GameOver").get_children():
		x.visible = false
	pass


func _on_Button_pressed():
	startGame()
	pass # Replace with function body.

func _on_HUD_buy_rate(score):
	if(score > 35):
		print("har råd med rate")
		score -= 35
		spawn_rate += 0.1
		emit_signal("update_score", score)
