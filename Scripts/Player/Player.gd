extends "res://Scripts/Base.gd"
class_name Player

@onready var collider: CollisionShape2D = $HitBox
@onready var throw_handler: Control = $ThrowComponent
@onready var player_camera: Camera2D = $Camera2D
@onready var sword: Area2D = $Sword
@onready var movement_component: PlayerMovementComponent = $PlayerMovementComponent
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var base_punch_count: int = 3

var punch_count: int = base_punch_count
var animation_controller: AnimationController

func _ready() -> void:
	animation_controller = AnimationController.new()
	animation_player.animation_finished.connect(on_animation_finished)
	animation_controller.animation_play(animation_controller.AnimationState.Idle, animation_player)

func calculate_punch_count(enemy_count: int) -> void:
	punch_count = max(base_punch_count - enemy_count, 0)

func _draw() -> void:
	movement_component.draw_blink_range()

func _process(_delta: float) -> void:
	throw_handler.queue_redraw()
	self.queue_redraw()

func _physics_process(delta: float) -> void:
	movement_component.process_movement(delta)
	
func on_animation_finished(_anim_name: StringName) -> void:
	if timer.is_stopped():
		animation_controller.reset_to_idle(animation_player)
	else:
		animation_controller.animation_play(animation_controller.AnimationState.Attack2, animation_player)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		Events.emit_signal("pause_menu_toggle", true)
		
	animation_controller.state_input(timer,event,animation_player)
