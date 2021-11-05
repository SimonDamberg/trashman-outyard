extends Area2D

signal hit_trash
var screen_size
export var speed = 50
export var runMultiplier  =2.5
func get_input():
	var velocity = Vector2()  # The player's movement vector.
	var total_rot = 0
	var realSpeed = speed;
	if Input.is_key_pressed(KEY_SHIFT):
		realSpeed = realSpeed*runMultiplier;
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.rotation_degrees = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.rotation_degrees = 180
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.rotation_degrees = 90
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.rotation_degrees = -90
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		$AnimatedSprite.rotation_degrees = -135		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		$AnimatedSprite.rotation_degrees = -45
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		$AnimatedSprite.rotation_degrees = 135		
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		$AnimatedSprite.rotation_degrees = 45	
	if velocity.length() > 0:
		velocity = velocity.normalized() * realSpeed
		$AnimatedSprite.speed_scale * realSpeed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	return velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_viewport().size
	var velocity = get_input()
	position += velocity * delta
	position.x = clamp(position.x, 50, screen_size.x-25) # TODO add offset
	position.y = clamp(position.y, 40, screen_size.y-20) # TODO add offset
	$AnimatedSprite.animation = "walk"

func _on_Player_body_entered(body):
	# TODO Add points to score counter
	if body.get_meta('type') == 'trash':
		emit_signal("hit_trash", body.value, body)
		$AnimatedSprite.animation = "pickup"
	elif body.get_meta('type') == 'trashCollector':
		print('TrashCollector')
