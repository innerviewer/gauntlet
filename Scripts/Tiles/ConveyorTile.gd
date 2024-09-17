extends Node2D

@export var conveyor_speed: float = 75

@onready var conveyor_area: Area2D = $Area2D
@onready var conveyor_velocity: Vector2 = Vector2(cos(rotation), sin(rotation)) * conveyor_speed
@onready var modifier_id: String = str(self.get_instance_id())


func _on_body_entered(body: Node2D) -> void:
	if 'velocity_modifiers' in body:
		body.velocity_modifiers[modifier_id] = conveyor_velocity
	else:
		print("DEBUG: not movable body on the conveyor tile.")
		
		
func _on_body_exited(body: Node2D) -> void: 
	if 'velocity_modifiers' in body:
		body.remove_velocity_modifier(modifier_id)
	else:
		print("DEBUG: not movable body on the conveyor tile.")
