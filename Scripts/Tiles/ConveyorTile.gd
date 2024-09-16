extends Node2D

@export var conveyor_speed: float = 75

@onready var conveyor_area: Area2D = $Area2D
@onready var conveyor_velocity: Vector2 = Vector2(cos(rotation), sin(rotation)) * conveyor_speed

func _on_body_entered(body: Node2D) -> void:
	if "velocity_modifier" in body:
		body.velocity_modifier += conveyor_velocity
	else:
		print("DEBUG: not movable body on the conveyor tile.")
		
		
func _on_body_exited(body: Node2D) -> void: 
	if "velocity_modifier" in body:
		body.velocity_modifier -= conveyor_velocity
	else:
		print("DEBUG: not movable body on the conveyor tile.")
