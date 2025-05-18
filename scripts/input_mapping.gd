extends Node

enum InputAction {
	MOVE_RIGHT,
	MOVE_LEFT,
	MOVE_UP,
	MOVE_DOWN,
	# Add other actions as needed
}

# Convert enum to corresponding action string
func get_action_string(action: int) -> String:
	match action:
		InputAction.MOVE_RIGHT:
			return "move_right"
		InputAction.MOVE_LEFT:
			return "move_left"
		InputAction.MOVE_UP:
			return "move_up"
		InputAction.MOVE_DOWN:
			return "move_down"
		_:
			return ""

# Check if action is pressed using enum
func is_action_pressed(action: int) -> bool:
	return Input.is_action_pressed(get_action_string(action))

# Debug utility function to log all input states
func log_input_states() -> void:
	print("=== INPUT STATES ===")
	print("RIGHT: ", Input.is_action_pressed("move_right"))
	print("LEFT: ", Input.is_action_pressed("move_left"))
	print("UP: ", Input.is_action_pressed("move_up"))
	print("DOWN: ", Input.is_action_pressed("move_down"))
	print("===================")