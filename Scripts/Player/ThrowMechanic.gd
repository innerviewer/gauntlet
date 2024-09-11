extends Control

@export var max_angle: float = 90.0 
@export var trajectory_color : Color
@export var trajectory_spacing : float
@export var trajectory_radius : float
@export var trajectory_angle_adjustment_speed : float

var throw_destination: Vector2
var is_drawing: bool = false
var curve_angle: float = 0.0
var previous_mouse_position: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("player_throw"):  # 'R' key pressed
		is_drawing = true
		throw_destination = get_global_mouse_position()
		previous_mouse_position = throw_destination

	if is_drawing:
		throw_destination = get_global_mouse_position()

		# Check if Left Shift is pressed to adjust the curve
		if Input.is_key_pressed(KEY_SHIFT):
			adjust_curve_angle()
		else: 
			curve_angle = 0.0

	# Stop drawing when the 'R' key is released 
	if Input.is_action_just_released("player_throw"):
		is_drawing = false
		
	previous_mouse_position = get_global_mouse_position()

func _draw() -> void: 
	if is_drawing:
		draw_curved_trajectory()

func draw_curved_trajectory():
	UtilsSignals.emit_signal("draw_dotted_curve", self, position, throw_destination, curve_angle, trajectory_spacing, trajectory_radius, trajectory_color)

func adjust_curve_angle() -> void:
	var current_mouse_position = get_global_mouse_position()
	var mouse_movement = current_mouse_position - previous_mouse_position
	var movement_direction = mouse_movement.angle()
	
	# Calculate angle difference
	var angle_diff = movement_direction - (throw_destination - position).angle()
	
	# Adjust curve_angle based on angle difference
	curve_angle += angle_diff * 0.1  # Adjust the multiplier to control sensitivity
	curve_angle = clamp(curve_angle, 0, max_angle)
