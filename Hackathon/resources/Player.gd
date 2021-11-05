extends Area2D

signal hit_trash
var screen_size
export var speed = 50
export var runMultiplier  =2.5
var inWall = false;
var wallRotation = 0;
func get_input():
	var velocity = Vector2()  # The player's movement vector.
	var total_rot = 0
	var realSpeed = speed;
	if Input.is_key_pressed(KEY_SHIFT):
		realSpeed = realSpeed*runMultiplier;
	if Input.is_action_pressed("ui_right"):
		if(!(inWall && wallRotation == 0)):
			velocity.x += 1
			$AnimatedSprite.rotation_degrees = 0
	if Input.is_action_pressed("ui_left"):
		if(!(inWall && wallRotation == 180)):
			velocity.x -= 1
			$AnimatedSprite.rotation_degrees = 180
	if Input.is_action_pressed("ui_down"):
		if(!(inWall && wallRotation == 90)):
			velocity.y += 1
			$AnimatedSprite.rotation_degrees = 90
	if Input.is_action_pressed("ui_up"):
		if(!(inWall && wallRotation == 270)):
			velocity.y -= 1
			$AnimatedSprite.rotation_degrees = 270

	if velocity.length() > 0:
		velocity = velocity.normalized() * realSpeed
		$AnimatedSprite.speed_scale * realSpeed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	return velocity

func hitWall(body):
	inWall = true;
	wallRotation = $AnimatedSprite.rotation_degrees

func leftWall():
	inWall =  false;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_viewport_rect().size
	var velocity = get_input()
	position += velocity * delta
	position.x = clamp(position.x, 50, screen_size.x-25)
	position.y = clamp(position.y, 40, screen_size.y-20)
	$AnimatedSprite.animation = "walk"

func _on_Player_body_entered(body):
	# TODO Add points to score counter
	if body.get_collision_layer() == 1:
		emit_signal("hit_trash", body.value, body)
		$AnimatedSprite.animation = "pickup"
	elif body.get_collision_layer() == 2:
		print('trashCollector')
	elif body.get_collision_layer() == 4:
		hitWall(body)

func _on_Player_body_exited(body):
	if body.get_collision_layer() == 4:
		leftWall()

