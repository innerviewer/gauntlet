extends "res://Scripts/Base.gd"

@onready var player : CharacterBody2D = get_node("/root/devel/Player")
@onready var dotted_line_util : Object = preload("res://Scripts/Utils/DottedLine.gd").new()

@export var fov_line_color : Color
@export var fov_line_spacing : float
@export var fov_line_radius : float

@export var attack_power : float = 10
@export var fov_angle : float = 90.0
@export var fov_length : float = 500.0
 
var player_in_sight : bool = false
var area : Area2D = null
var polygon_points : PackedVector2Array = []

func create_cone_collision_shape() -> PackedVector2Array:
    var half_angle = deg_to_rad(fov_angle / 2)
    var left_point = Vector2(fov_length * cos(half_angle), fov_length * sin(half_angle))
    var right_point = Vector2(fov_length * cos(half_angle), -fov_length * sin(half_angle))

    return [Vector2(0, 0), right_point, left_point]
        
func _ready() -> void:
    polygon_points = create_cone_collision_shape()
    var collision_shape : CollisionPolygon2D = CollisionPolygon2D.new()
    collision_shape.polygon = polygon_points
    
    area = Area2D.new()
    add_child(area)
    area.add_child(collision_shape)
    area.body_entered.connect(_on_fov_entered)
    area.body_exited.connect(_on_fov_exited)

func _on_fov_entered(body: Node):
    if body.is_in_group("Player"):
        player_in_sight = true

func _on_fov_exited(body: Node):
    if body.is_in_group("Player"):
        player_in_sight = false

func _draw() -> void: 
    dotted_line_util.draw_dotted_line(self, polygon_points[0], 
                                    polygon_points[0] + polygon_points[1],
                                    fov_line_spacing, fov_line_radius, fov_line_color)
                                    
    dotted_line_util.draw_dotted_line(self, polygon_points[0], 
                                    polygon_points[0] + polygon_points[2],
                                    fov_line_spacing, fov_line_radius, fov_line_color)
    

func _physics_process(_delta):
    if player_in_sight:
        var direction = (player.position - position).normalized()
        velocity = direction * move_speed
        rotation = direction.angle()
        move_and_slide() 
