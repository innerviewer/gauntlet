extends "res://Scripts/Base.gd"

@onready var health_bar: ProgressBar = $HealthBar
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var throw_handler: Control = $ThrowComponent

@export var base_damage: float = 10
@export var base_punch_count: int = 3
@export var blink_range: int = 800

var punch_count: int = base_punch_count

func calculate_punch_count(enemy_count: int) -> void:
	punch_count = max(base_punch_count - enemy_count, 0)

func _process(_delta: float) -> void:
	throw_handler.queue_redraw()

func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	velocity = input_direction * move_speed
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"):
		var blink_position: Vector2 = get_global_mouse_position()
		if position.distance_to(blink_position) <= blink_range:
			position = blink_position
			
	if event.is_action_pressed("ui_cancel"):
		Events.emit_signal("open_settings")
