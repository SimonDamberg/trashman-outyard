extends Area2D

signal hit_trash
var screen_size
export var speed = 50

func get_input():
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = get_input()
	position += velocity * delta
	position.x = clamp(position.x, 10, screen_size.x-10) # TODO add offset
	position.y = clamp(position.y, 10, screen_size.y-10) # TODO add offset

func _on_Player_body_entered(body):
	# TODO Check id of trash 
	# TODO Add points to score counter
	emit_signal("hit_trash", body.value)
