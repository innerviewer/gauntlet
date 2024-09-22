extends Node2D

@export var slipperiness: float = 2

var slippery_bodies: Array = []


func _on_body_entered(body: Node2D) -> void:
	if 'velocity_modifiers' in body:
		body.velocity_modifiers['slippery_tile'] = slipperiness
	else:
		print("DEBUG: not movable body on the sticky tile.")

func _on_body_exited(body: Node2D) -> void:
	if 'velocity_modifiers' in body:
		slippery_bodies.append(body)
	else:
		print("DEBUG: not movable body on the sticky tile.")
		
func _process(delta: float) -> void:
	for body in slippery_bodies:
		body.velocity_modifiers['slippery_tile'] = max(body.velocity_modifiers['slippery_tile'] - delta, 1.0)
