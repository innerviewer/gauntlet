extends Node2D
class_name ShaderComponent

@onready var character_sprite: Sprite2D = $"../Sprite2D"

func flash_shader() -> void:
	character_sprite.material.set("shader_parameter/flash_modifier", 1.0)
	await get_tree().create_timer(0.1).timeout
	character_sprite.material.set("shader_parameter/flash_modifier", 0.0)

func create_trail_effect(start_position: Vector2) -> void:
	var trail_sprite: Sprite2D = character_sprite.duplicate()
	
	# относительно родителя
	trail_sprite.position = start_position - character_sprite.get_parent().position
	trail_sprite.modulate = Color(1, 1, 1, 1) 

	var new_material: Material = trail_sprite.material.duplicate()
	trail_sprite.material = new_material

	character_sprite.get_parent().add_child(trail_sprite)

	trail_sprite.material.set("shader_parameter/mix_color", 1.0)
	trail_sprite.material.set("shader_parameter/opacity", 0.5)
	await get_tree().create_timer(0.3).timeout
	trail_sprite.material.set("shader_parameter/mix_color", 0.0)
	trail_sprite.material.set("shader_parameter/opacity", 0.0)
	trail_sprite.queue_free()
