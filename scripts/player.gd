extends Area2D

# Get reference to our input mapping singleton
@onready var input_map = $"/root/InputMapping"

# export sets value in inspector
@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	
	# Using the InputMapping enum for input actions
	if input_map.is_action_pressed(input_map.InputAction.MOVE_RIGHT):
		velocity.x += 1
	if input_map.is_action_pressed(input_map.InputAction.MOVE_LEFT):
		velocity.x -= 1
	if input_map.is_action_pressed(input_map.InputAction.MOVE_DOWN):
		velocity.y += 1
	if input_map.is_action_pressed(input_map.InputAction.MOVE_UP):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
