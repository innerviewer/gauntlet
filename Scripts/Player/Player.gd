extends "res://Scripts/Base.gd"

@onready var health_bar : ProgressBar = $HealthBar

@export var base_damage : float = 10
@export var base_punch_count : int = 3

var punch_count : int = base_punch_count

func calculate_punch_count(enemy_count: int) -> void:
	punch_count = max(base_punch_count - enemy_count, 0)
	print("Current punches: " + str(punch_count))

#func _draw() -> void: 
#	var damage_str = "Damage: " + str(damage)
#	draw_string(ThemeDB.fallback_font, Vector2(64, 64), damage_str, HORIZONTAL_ALIGNMENT_LEFT, -1, ThemeDB.fallback_font_size)

#func _process(_delta) -> void: 
#	if 

func _physics_process(_delta) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * move_speed
	
	move_and_slide()

func _input(event) -> void:
	if event.is_action_pressed("blink"):
		position = get_global_mouse_position()
