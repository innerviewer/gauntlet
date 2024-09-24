extends MovementComponent
class_name PlayerMovementComponent

@export var blink_range: int = 800

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"):
		blink()

func process_movement(delta: float) -> Vector2:
	var input_direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	var velocity: Vector2 = input_direction * move_speed
	velocity = apply_modifiers(delta, velocity)
	
	return velocity

func blink() -> void:
	var blink_position: Vector2 = parent.get_global_mouse_position()
	var direction: Vector2 = blink_position - parent.position
	var distance: float = direction.length()
	
	if distance > blink_range:
		direction = direction.normalized() * 0.75
		parent.position += direction
	else:
		parent.position = blink_position 
