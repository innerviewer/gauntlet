extends Control

@onready var line_drawer = $LineDrawerComponent

@export var max_angle: float = 45.0 
@export var trajectory_color : Color
@export var trajectory_spacing : float
@export var trajectory_radius : float
@export var trajectory_angle_adjustment_speed : float = 5

var throw_destination: Vector2
var is_drawing: bool = false
var curve_angle: float = 0.0
var previous_mouse_position: Vector2 = Vector2.ZERO

func _ready() -> void: 
	line_drawer.spacing = trajectory_spacing
	line_drawer.color = trajectory_color
	line_drawer.radius = trajectory_radius

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("player_throw"):  # 'R' key pressed
		is_drawing = true
		throw_destination = get_local_mouse_position()
		previous_mouse_position = throw_destination

	if is_drawing:
		if Input.is_key_pressed(KEY_SHIFT):
			adjust_curve_angle()
		else:
			throw_destination = get_local_mouse_position()
			curve_angle = 0.0
			
		if Input.is_action_just_released("player_throw"):
			is_drawing = false
			curve_angle = 0.0 
		
	previous_mouse_position = get_local_mouse_position()

func _draw() -> void: 
	if is_drawing:
		draw_curved_trajectory()

func draw_curved_trajectory() -> void:
	line_drawer.start_point = position
	line_drawer.end_point = throw_destination
	line_drawer.angle = curve_angle
	line_drawer.draw_dotted_curve()

func adjust_curve_angle() -> void:
	var current_mouse_position = get_local_mouse_position()
	var mouse_movement = current_mouse_position - previous_mouse_position
	
	# Get throw direction and perpendicular vectortination)
	var throw_direction = (throw_destination - position).normalized()
	var perpendicular_direction = Vector2(-throw_direction.y, throw_direction.x)
	
	# Project the mouse movement onto the perpendicular direction
	var perpendicular_movement = mouse_movement.dot(perpendicular_direction)
	perpendicular_movement = clamp(perpendicular_movement, -1, 1) # Clamp to avoid large jumps
	
	var angle_change = perpendicular_movement * trajectory_angle_adjustment_speed
	
	curve_angle += angle_change
	curve_angle = clamp(curve_angle, -max_angle, max_angle)
	
	# Update the previous mouse position for the next frame
	previous_mouse_position = current_mouse_position
