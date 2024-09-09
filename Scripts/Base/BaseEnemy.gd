extends "res://Scripts/Base.gd"

@export var attack_power : float = 10
@export var FOV : float = 50.0
@export var max_view_distance : float = 800.0
@export var angle_between_rays : float = 1.0

var rays : Array

func generate_raycasts() -> void: 
	FOV = deg_to_rad(FOV)
	angle_between_rays = deg_to_rad(angle_between_rays)	
	var ray_count := FOV /  angle_between_rays
	
	for i in ray_count: 
		var ray := RayCast2D.new()
		var angle := angle_between_rays * (i - ray_count / 2.0)
		ray.target_position = Vector2.RIGHT.rotated(angle) * max_view_distance
		add_child(ray)
		ray.enabled = true
		rays.append(ray)
		
func attack(target):
	if target:
		target.take_damage(attack_power) 
		
func _ready() -> void:
	generate_raycasts()

func _draw() -> void: 
	draw_line(rays[0].position, rays[0].position + rays[0].target_position, Color.RED, 5.0)
	draw_line(rays[-1].position, rays[-1].position + rays[-1].target_position, Color.RED, 5.0)

func _physics_process(_delta):
	var target = null
	for ray in rays: 
		if ray.is_colliding() and ray.get_collider() and ray.get_collider().is_in_group("Player"):
			target = ray.get_collider()
	
	if target != null: 
		var direction = (target.position - position).normalized()
		rotation = direction.angle()
		velocity = direction * move_speed
		move_and_slide() 
