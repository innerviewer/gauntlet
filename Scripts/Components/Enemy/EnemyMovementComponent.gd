extends MovementComponent
class_name EnemyMovementComponent

func process_movement(delta: float, player_in_sight: bool, player: CharacterBody2D) -> Vector2:
	if not player_in_sight:
		return Vector2()
	
	var direction: Vector2 = (player.position - parent.position).normalized()
	var velocity: Vector2 = direction * move_speed
	velocity = apply_modifiers(delta, velocity)
	
	return velocity 
