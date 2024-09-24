extends Node
class_name AnimationController 

enum AnimationState { IDLE, RUN, ATTACK }

func animation_play(state: AnimationState,sprite: AnimatedSprite2D) -> void:
	match state:
		AnimationState.IDLE:
			sprite.play("idle")
		AnimationState.RUN:
			sprite.play("run")
		AnimationState.ATTACK:
			sprite.play("attack1")
		_:
			print("Unknown animation state:", state)
			

func reset_to_idle(sprite: AnimatedSprite2D) -> void:
	sprite.play("idle")

func get_current_animation(sprite: AnimatedSprite2D) -> String:
	return sprite.animation
