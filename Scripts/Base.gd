extends CharacterBody2D

@export var health: float = 100
@export var move_speed: float = 200

var velocity_modifier: Vector2 = Vector2.ZERO

func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		die()
		
		
func die() -> void:
	queue_free()
