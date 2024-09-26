extends "res://Scripts/Base.gd"
class_name BaseEnemy

@onready var player : CharacterBody2D = get_node("/root/devel/Player")
@onready var line_drawer: LineDrawer = $LineDrawerComponent
@onready var movement_component: EnemyMovementComponent = $EnemyMovementComponent

@export var fov_line_color : Color
@export var fov_line_spacing : float
@export var fov_line_radius : float

@export var fov_angle : float = 90.0
@export var fov_length : float = 500.0
 
var player_in_sight : bool = false
var area : Area2D = null
var polygon_points : PackedVector2Array = []
var draw_trajectories: bool = false

func create_cone_collision_shape() -> PackedVector2Array:
	var half_angle: float = deg_to_rad(fov_angle / 2)
	var left_point: Vector2 = Vector2(fov_length * cos(half_angle), fov_length * sin(half_angle))
	var right_point: Vector2 = Vector2(fov_length * cos(half_angle), -fov_length * sin(half_angle))

	return [Vector2(0, 0), right_point, left_point]
		
func _ready() -> void:
	create_fov_visualization()
	
func create_fov_visualization() -> void:
	polygon_points = create_cone_collision_shape()
	var collision_shape : CollisionPolygon2D = CollisionPolygon2D.new()
	collision_shape.polygon = polygon_points
	
	area = Area2D.new()
	add_child(area)
	area.add_child(collision_shape)
	area.body_entered.connect(_on_fov_entered)
	area.body_exited.connect(_on_fov_exited)
	line_drawer.spacing = fov_line_spacing
	line_drawer.color = fov_line_color
	line_drawer.radius = fov_line_radius
	

func _on_fov_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_in_sight = true

func _on_fov_exited(body: Node)  -> void:
	if body.is_in_group("Player"):
		player_in_sight = false

func _draw() -> void: 
	if not draw_trajectories:
		return
		
	line_drawer.start_point = polygon_points[0]
	line_drawer.end_point = polygon_points[0] + polygon_points[1]
	line_drawer.draw_dotted_line()

	line_drawer.end_point = polygon_points[0] + polygon_points[2]
	line_drawer.draw_dotted_line()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("helper_ui"):
		draw_trajectories = true
		self.queue_redraw()
	elif event.is_action_released("helper_ui"):
		draw_trajectories = false
		self.queue_redraw()

func _physics_process(delta: float)  -> void:
	velocity = movement_component.process_movement(delta, player_in_sight, player)
	move_and_slide()
