extends CharacterBody2D

@onready var player : CharacterBody2D = get_node("/root/devel/PlayerChar")
var target : CharacterBody2D = null

@export var speed : float = 200
@export var FOV : float = 150.0
@export var max_view_distance : float = 800.0
@export var angle_between_rays : float = 1.0

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
		
		#var line := Line2D.new()
		#add_child(line)
		#line.default_color = Color(0, 1, 0, 1)
		#line.add_point((Vector2.RIGHT.rotated(angle) * max_view_distance), 1)
		

func _ready() -> void:
	generate_raycasts()

func _draw() -> void: 
	for ray in get_children(): 
		if ray is RayCast2D:
			draw_line(ray.position, ray.position + ray.target_position, Color.RED, 5.0)

func _physics_process(_delta):
	target = null
	for ray in get_children(): 
		if ray is RayCast2D and ray.is_colliding() and ray.get_collider() is CharacterBody2D:
			target = ray.get_collider()
			print("seeing")
	
	if target != null: 
		var direction = (target.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide() 
