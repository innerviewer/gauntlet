extends "res://Classes/BaseCharacter.gd"

@onready var health_bar = $HealthBar

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * move_speed
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("blink"):
		position = get_global_mouse_position()
