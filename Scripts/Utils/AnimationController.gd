extends Node
class_name AnimationController 

@export var idle_name: String = "idle"
@export var attack1_name: String = "attack1"
@export var attack2_name: String = "attack2"
@export var run_name: String = "run"

enum AnimationState { 
	Idle, 
	Run, 
	Attack1,
	Attack2
}

func animation_play(state: AnimationState,animation_player: AnimationPlayer) -> void:
	match state:
		AnimationState.Idle:
			animation_player.play(idle_name)
		AnimationState.Run:
			animation_player.play(run_name)
		AnimationState.Attack1:
			animation_player.play(attack1_name)
		AnimationState.Attack2:
			animation_player.play(attack2_name)
		_:
			print("Unknown animation state:", state)
			

func reset_to_idle(animation_player: AnimationPlayer) -> void:
	animation_player.play(idle_name)

func get_current_animation(sprite: AnimationPlayer) -> String:
	return sprite.animation
	
func state_input(timer: Timer,event: InputEvent,animation_player: AnimationPlayer) -> void:
	if event.is_action_pressed(attack1_name):
		timer.start()
		animation_play(AnimationState.Attack1, animation_player)
