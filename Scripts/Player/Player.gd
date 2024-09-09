extends "res://Scripts/Base.gd"

@onready var health_bar = $HealthBar
@export var base_damage : float = 10

var damage : float = base_damage

func calculate_damage(enemy_count: int) -> void:
	if enemy_count <= 1:
		print("Current damage: " + str(damage))
		damage = base_damage
		return
	
	damage = max(base_damage - (2 ** enemy_count), 0)
	print("Current damage: " + str(damage))

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
