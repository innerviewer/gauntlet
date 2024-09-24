extends "res://Scripts/Base.gd"
class_name Player

@onready var collider: CollisionShape2D = $HitBox
@onready var throw_handler: Control = $ThrowComponent
@onready var player_camera: Camera2D = $Camera2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: Area2D = $Sword
@onready var movement_component: PlayerMovementComponent = $PlayerMovementComponent

@export var base_punch_count: int = 3

var punch_count: int = base_punch_count
var animation_controller: AnimationController

func _ready() -> void:
	animated_sprite.animation_finished.connect(on_animation_finished)
	animation_controller = AnimationController.new()
	animation_controller.animation_play(animation_controller.AnimationState.IDLE, animated_sprite)

func calculate_punch_count(enemy_count: int) -> void:
	punch_count = max(base_punch_count - enemy_count, 0)

func _process(_delta: float) -> void:
	throw_handler.queue_redraw()

func _physics_process(delta: float) -> void:
	velocity = movement_component.process_movement(delta)
	move_and_slide()
	
func on_animation_finished() -> void:
	print("animation finished")
	animation_controller.reset_to_idle(animated_sprite)
	sword.monitoring = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		Events.emit_signal("pause_menu_toggle", true)
	
	if event.is_action_pressed("attack1"):
		animation_controller.animation_play(AnimationController.AnimationState.ATTACK, animated_sprite)
		sword.monitoring = true
