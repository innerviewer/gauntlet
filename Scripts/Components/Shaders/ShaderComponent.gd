extends Node2D
class_name ShaderComponent

@onready var character_sprite: Sprite2D = $"../Sprite2D"

func flash_shader() -> void:
	character_sprite.material.set("shader_parameter/flash_modifier", 1.0)
	await get_tree().create_timer(0.1).timeout
	character_sprite.material.set("shader_parameter/flash_modifier", 0.0)

func create_trail_effect(start_position: Vector2, end_position: Vector2) -> void:
	var segments: int = 10 # Количество следов
	var interval: float = 0.1 # Интервал времени между созданием дубликатов
	var step: Vector2 = (end_position - start_position) / segments
	var previous_trail_sprite: Sprite2D = null
		
	for i in range(segments):
		await get_tree().create_timer(interval).timeout # Задержка перед созданием каждого следа
		var trail_sprite: Sprite2D = character_sprite.duplicate()
		
		if previous_trail_sprite:
			previous_trail_sprite.queue_free()
			
		# Позиция вдоль пути телепортации
		trail_sprite.position = start_position + step * i - character_sprite.get_parent().position
		trail_sprite.modulate = Color(1, 1, 1, 1) 
		
		var new_material: Material = trail_sprite.material.duplicate()
		trail_sprite.material = new_material
		
		character_sprite.get_parent().add_child(trail_sprite)
		
		trail_sprite.material.set("shader_parameter/mix_color", 1.0 - (i / segments))
		trail_sprite.material.set("shader_parameter/opacity", 0.5 - (i / segments))
		
		previous_trail_sprite = trail_sprite
		
	if previous_trail_sprite:
		await get_tree().create_timer(interval).timeout
		previous_trail_sprite.queue_free()
