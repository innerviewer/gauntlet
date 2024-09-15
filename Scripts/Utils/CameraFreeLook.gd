extends Camera2D

@export var target_node: Node2D = null
@export var min_zoom: float = 0.5
@export var max_zoom: float = 1.0
@export var zoom_speed: float = 0.25

var is_following_mouse: bool = false

func _ready() -> void: 
	if target_node == null:
		target_node = get_parent()

func follow_target(target_position: Vector2) -> void: 
	self.position = target_position.normalized() * target_position.length() * 0.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("look_around"):
		is_following_mouse = true
	elif event.is_action_released("look_around"): 
		is_following_mouse = false

func zoom_in() -> void:
	var new_zoom: Vector2 = zoom + Vector2(zoom_speed, zoom_speed)
	self.zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

func zoom_out() -> void:
	var new_zoom: Vector2 = zoom - Vector2(zoom_speed, zoom_speed)
	self.zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

func _process(_delta: float) -> void: 
	if is_following_mouse:
		if Input.is_action_just_pressed("zoom_in"):
			zoom_in()
		elif Input.is_action_just_pressed("zoom_out"):
			zoom_out()
			
		var mouse_position: Vector2 = get_local_mouse_position() 
		self.position = mouse_position.normalized() * mouse_position.length() * 0.5
	else: 
		self.zoom = Vector2.ONE
		self.position = target_node.position
