extends Node
class_name AnimationComponent

@onready var animation_state: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $"../Sprite2D"
@onready var timer: Timer = $Timer

@export var attack1_name: String = "attack1"
@export var attack2_name: String = "attack2"
@export var idle_or_run: String = "move"

enum AnimationState { 
	Attack1,
	Attack2,
}

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
			animation_state.travel(attack1_name)
		AnimationState.Attack2:
			animation_state.travel(attack2_name)
		_:
			print("Unknown animation state:", state)

func update_facing_direction(direction: Vector2,sword: Area2D) -> void:
	if direction.x > 0:
		sprite.flip_h = false
		sword.scale.x = abs(sword.scale.x)
	elif direction.x < 0:
		sprite.flip_h = true
		sword.scale.x = -abs(sword.scale.x)

func update_direction_animations(direction: Vector2) -> void:
	animation_tree.set("parameters/move/blend_position",direction)

func reset_to_idle() -> void:
	animation_state.travel(idle_or_run)

func get_current_animation() -> String:
	return animation_state.get_current_node()

func state_input(event: InputEvent) -> void:
	if event.is_action_pressed(attack1_name):
		timer.start()
		animation_play(AnimationState.Attack1)
