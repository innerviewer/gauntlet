extends Control

@onready var line_drawer: LineDrawer = $LineDrawerComponent

@export var max_angle: float = 45.0
@export var max_throw_distance: float = 1000.0
@export var trajectory_color : Color
@export var trajectory_spacing : float
@export var trajectory_radius : float
@export var trajectory_angle_adjustment_speed : float = 5

var throw_destination: Vector2 = Vector2.ZERO
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
        limit_throw_distance()
        previous_mouse_position = throw_destination

    if is_drawing:
        if Input.is_key_pressed(KEY_SHIFT):
            adjust_curve_angle()
        else:
            throw_destination = get_local_mouse_position()
            limit_throw_distance()
            curve_angle = 0.0
            
        if Input.is_action_just_released("player_throw"):
            previous_mouse_position = Vector2.ZERO
            is_drawing = false
            curve_angle = 0.0
            return
        
        previous_mouse_position = get_local_mouse_position()

func _draw() -> void:
    if is_drawing:
        draw_curved_trajectory()


func limit_throw_distance() -> void:
    var throw_direction: Vector2 = (throw_destination - position)
    
    if throw_direction.length() <= max_throw_distance:  
        return 
        
    throw_direction = throw_destination.limit_length(max_throw_distance)
    throw_destination = position + throw_direction

func draw_curved_trajectory() -> void:
    line_drawer.start_point = position
    line_drawer.end_point = throw_destination
    line_drawer.angle = curve_angle
    line_drawer.draw_dotted_curve()

func adjust_curve_angle() -> void:
    var current_mouse_position: Vector2 = get_local_mouse_position()
    var mouse_movement: Vector2 = current_mouse_position - previous_mouse_position
    
    # Get throw direction and perpendicular vectortination)
    var throw_direction: Vector2 = (throw_destination - position).normalized()
    var perpendicular_direction: Vector2 = Vector2(-throw_direction.y, throw_direction.x)
    
    # Project the mouse movement onto the perpendicular direction
    var perpendicular_movement: float = mouse_movement.dot(perpendicular_direction)
    perpendicular_movement = clamp(perpendicular_movement, -1, 1) # Clamp to avoid large jumps
    
    var angle_change: float = perpendicular_movement * trajectory_angle_adjustment_speed
    
    curve_angle += angle_change
    curve_angle = clamp(curve_angle, -max_angle, max_angle)
    
    # Update the previous mouse position for the next frame
    previous_mouse_position = current_mouse_position
