extends Node
class_name AnimationComponent

@onready var animation_state: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $"../Sprite2D"
@onready var timer: Timer = $Timer

@export var attack1: String = "attack1"
@export var attack2: String = "attack2"
@export var idle: String = "idle"
@export var walk: String = "walk"
var animations_direction: Vector2

enum AnimationState { 
	Attack1,
	Attack2,
}

func set_direction(direction: Vector2) -> void:
	animations_direction = direction

func _ready() -> void:
	animation_tree.animation_finished.connect(on_animation_finished)

func on_animation_finished(_anim_name: StringName) -> void:
	if timer.is_stopped():
		reset_to_idle()
	else:
		animation_play(AnimationState.Attack2)

func animation_play(state: AnimationState) -> void:
	match state:
		AnimationState.Attack1:
			animation_state.travel(attack1)
			animation_tree.set("parameters/attack1/blend_position", animations_direction) 
		AnimationState.Attack2:
			animation_state.travel(attack2)
			animation_tree.set("parameters/attack2/blend_position", animations_direction)  
		_:
			print("Unknown animation state:", state)

func update_facing_direction(direction: Vector2,sword: Area2D) -> void:
	if direction.x > 0:
		sword.scale.x = abs(sword.scale.x)
	elif direction.x < 0:
		sword.scale.x = -abs(sword.scale.x)

func update_direction_animations(direction: Vector2) -> void:
	if is_attacking():
		return  
		
	if direction == Vector2.ZERO:
		animation_state.travel(idle)
	else:
		animation_state.travel(walk)
		animation_tree.set("parameters/walk/blend_position",direction)
		animation_tree.set("parameters/idle/blend_position",direction)

func reset_to_idle() -> void:
	animation_state.travel(idle)

func is_attacking() -> bool:
	return get_current_animation() in [attack1, attack2]

func get_current_animation() -> String:
	return animation_state.get_current_node()

func state_input() -> void:
	timer.start()
	animation_play(AnimationState.Attack1)
