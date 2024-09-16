extends "res://Scripts/Base.gd"

@onready var collider: CollisionShape2D = $HitBox
@onready var throw_handler: Control = $ThrowComponent
@onready var player_camera: Camera2D = $Camera2D

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
	
	velocity = input_direction * move_speed + velocity_modifier
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"):
		var blink_position: Vector2 = get_global_mouse_position()
		if position.distance_to(blink_position) <= blink_range:
			position = blink_position
			
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		Events.emit_signal("pause_menu_toggle", true)


# _on_hurtbox_area_entered должна быть в скрипте HurtboxComponent Оружия(перчаток)
# связанная с сигналом area_entered()
var attack_damage := 10.0 
#var knockback_force := 100.0 
#var stun_time := 1.5 

func _on_hurtbox_area_entered(area: Area2D)->void:
	if area is HurtboxComponent:
		var hurtbox: HurtboxComponent = area
		var attack: Attack = Attack.new()
		attack.attack_damage = attack_damage
		#attack.knockback_force = knockback_force
		#attack.attack_position = global_position
		#attack.stun_time = stun_time
		
		hurtbox.damage(attack)
