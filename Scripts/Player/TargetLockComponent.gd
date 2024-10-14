extends Area2D
class_name TargetLockComponent

@onready var player: Player = $".."
@onready var camera: Camera2D = $"../Camera2D"

var current_lock: Node2D = null  
var is_targeting: bool = false

func _ready() -> void:
	self.area_exited.connect(on_area_exited)

# наверно стоит сделать получше 
func _process(_delta: float) -> void: 
	if is_targeting:
		var new_lock:Node2D = target_lock(player.global_position)
		if new_lock != current_lock:
			current_lock = new_lock

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE:
		if !is_targeting:
			target_lock(player.global_position)
		else:
			target_unlock()

func target_lock(player_position: Vector2) -> Node2D:
	is_targeting = true
	var overlapping_bodies: Array = self.get_overlapping_areas()
	return find_closest_target(overlapping_bodies, player_position)

func find_closest_target(bodies: Array, player_position: Vector2) -> Node2D:
	var closest_node: Node2D = null
	var closest_distance: float = INF
	
	for body: Area2D in bodies:
		if body is HurtboxComponent:
			var distance_to_enemy: float = player_position.distance_squared_to(body.global_position)
			
			if distance_to_enemy < closest_distance: 
				closest_distance = distance_to_enemy
				closest_node = body
	
	current_lock = closest_node
	return closest_node

func draw_target_lock() -> void: 
	if not current_lock: 
		return
	
	var enemy_position:Vector2 = current_lock.global_position - player.global_position
	player.draw_circle(enemy_position, 5.0, Color.RED)
	camera.set_position(enemy_position)

func target_unlock() -> void:
	is_targeting = false
	current_lock = null

func on_area_exited(area: Area2D) -> void:
	if area.get_parent() == current_lock:
		target_unlock()
