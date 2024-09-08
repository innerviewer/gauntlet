extends CharacterBody2D

@export var health : float = 100
@export var move_speed : float = 200

func take_damage(amount) -> void:
	health -= amount
	if health <= 0:
		die()
		
		
func die() -> void:
	queue_free()
