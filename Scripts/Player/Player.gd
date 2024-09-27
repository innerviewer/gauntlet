extends "res://Scripts/Base.gd"
class_name Player

@onready var movement_component: PlayerMovementComponent = $PlayerMovementComponent
@onready var animations_component: AnimationConmponent = $AnimationsComponent
@onready var throw_handler: Control = $ThrowComponent
@onready var collider: CollisionShape2D = $HitBox
@onready var player_camera: Camera2D = $Camera2D
@onready var sword: Area2D = $Sword

@export var base_punch_count: int = 3

var punch_count: int = base_punch_count

func _ready() -> void:
	animations_component.animation_play(animations_component.AnimationState.Idle)

func calculate_punch_count(enemy_count: int) -> void:
	punch_count = max(base_punch_count - enemy_count, 0)

func _draw() -> void:
	movement_component.draw_blink_range()

func _process(_delta: float) -> void:
	throw_handler.queue_redraw()
	self.queue_redraw()

func _physics_process(delta: float) -> void:
	movement_component.process_movement(delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		Events.emit_signal("pause_menu_toggle", true)
		
	animations_component.state_input(event)
