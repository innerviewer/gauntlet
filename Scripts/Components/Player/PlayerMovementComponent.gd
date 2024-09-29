extends MovementComponent
class_name PlayerMovementComponent

@export var blink_restraint: float = 0.75
@export var blink_range: int = 400

@onready var animations_component: AnimationComponent = $"../AnimationsComponent"
@onready var sword: Area2D = $"../Sword"

var reveal_blink_range: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"):
		blink()
	
	if event.is_action_pressed("helper_ui"):
		reveal_blink_range = true
	elif event.is_action_released("helper_ui"):
		reveal_blink_range = false

func draw_blink_range() -> void:
	if reveal_blink_range:
		parent.draw_circle(Vector2.ZERO, blink_range, Color.LIME_GREEN, false, 1.0, true)

func process_movement(delta: float) -> void:
	var input_direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	var velocity: Vector2 = input_direction * move_speed
	velocity = apply_modifiers(delta, velocity)
	
	parent.velocity = velocity
	parent.move_and_slide()
	
	animations_component.update_direction_animations(input_direction)
	animations_component.update_facing_direction(input_direction,sword)

func blink() -> void:
	var blink_position: Vector2 = parent.get_global_mouse_position()
	var direction: Vector2 = blink_position - parent.position
	var distance: float = direction.length()
	
	if distance > blink_range:
		direction = direction.normalized() * (blink_range * blink_restraint) 
		parent.position += direction
	else:
		parent.position = blink_position 
