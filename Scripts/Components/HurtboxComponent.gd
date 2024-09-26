extends Area2D
class_name HurtboxComponent

@onready var sprite: Sprite2D = $"../Sprite2D"
@export var health_component : HealthComponent

func damage(attack: Attack) -> void:
	if health_component and sprite.is_in_group("Enemy"):
		health_component.damage(attack)

func flash(area: Area2D) -> void:
	if area is HurtboxComponent and sprite.is_in_group("Enemy"):
		sprite.material.set("shader_parameter/flash_modifer", 1.0)
		await get_tree().create_timer(0.1).timeout
		sprite.material.set("shader_parameter/flash_modifer", 0.0)
