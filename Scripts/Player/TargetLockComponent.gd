extends Area2D
class_name TargetLockComponent

@onready var parent: Node = get_parent()

var current_lock: Node2D = null  


func draw_target_lock() -> void: 
	if not current_lock: return
	 
	parent.draw_circle(current_lock.global_position - parent.global_position, 5.0, Color.WHITE)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE:
		target_lock(event.global_position)

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() == current_lock:
		current_lock = null

func _process(_delta: float) -> void: 
	parent.queue_redraw()

func target_lock(mouse_position: Vector2) -> void:
	current_lock = null
		
	var overlapping_bodies: Array = self.get_overlapping_areas()
	var closest_node: Node2D = null
	var closest_distance: float = INF
	
	for body: Node2D in overlapping_bodies:
		body = body.get_parent() # get parent of the HurtBox component.
		var distance_to_enemy: float = mouse_position.distance_to(body.global_position)
		
		if distance_to_enemy < closest_distance: 
			closest_distance = distance_to_enemy
			closest_node = body
			
			
	if closest_node:
		current_lock = closest_node
		
