extends CharacterBody2D

@export var health: float = 100
@export var move_speed: float = 200
var velocity_modifiers: Dictionary = {}

func remove_velocity_modifier(modifier_id: String) -> void: 
	if modifier_id in velocity_modifiers:
		velocity_modifiers.erase(modifier_id)

func apply_velocity_modifiers() -> void: 
	@warning_ignore("untyped_declaration")
	for modifier in velocity_modifiers.values():
		assert(modifier is float or modifier is Vector2, "Velocity modifier should be a float or Vector2.")
		if modifier is float:
			velocity *= modifier
		elif modifier is Vector2:
			velocity += modifier
