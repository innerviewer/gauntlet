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

func animation_play(state: AnimationState,sprite: AnimatedSprite2D) -> void:
	match state:
		AnimationState.Idle:
			sprite.play(idle_name)
		AnimationState.Run:
			sprite.play(run_name)
		AnimationState.Attack1:
			sprite.play(attack1_name)
		AnimationState.Attack2:
			sprite.play(attack2_name)
		_:
			print("Unknown animation state:", state)
			

func reset_to_idle(sprite: AnimatedSprite2D) -> void:
	sprite.play(idle_name)

func get_current_animation(sprite: AnimatedSprite2D) -> String:
	return sprite.animation
	
func state_input(timer: Timer,event: InputEvent,area: Area2D,sprite: AnimatedSprite2D) -> void:
	if event.is_action_pressed(attack1_name):
		timer.start()
		animation_play(AnimationState.Attack1, sprite)
		area.monitoring = true
