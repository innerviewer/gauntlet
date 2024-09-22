extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D

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
			
func flash(area: Area2D) -> void:
	if area is HurtboxComponent:
		sprite.material.set("shader_parameter/flash_modifer", 1.0) 
		await get_tree().create_timer(0.1).timeout
		sprite.material.set("shader_parameter/flash_modifer", 0.0)
			
