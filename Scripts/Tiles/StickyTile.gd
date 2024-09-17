extends Node2D

@export var stickiness: float = 0.5

@onready var modifier_id: String = str(self.get_instance_id())
@onready var sticky_area: Area2D = $Area2D

func _on_body_entered(body: Node2D) -> void:
	if 'velocity_modifiers' in body:
		body.velocity_modifiers[modifier_id] = 0.5
	else:
		print("DEBUG: not movable body on the sticky tile.")

func _on_body_exited(body: Node2D) -> void:
	if 'velocity_modifiers' in body:
		body.remove_velocity_modifier(modifier_id)
	else:
		print("DEBUG: not movable body on the sticky tile.")
