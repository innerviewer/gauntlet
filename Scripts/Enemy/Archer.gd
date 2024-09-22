extends "res://Scripts/Enemy/BaseEnemy.gd"

@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

func _ready() -> void:
	create_fov_visualization()
	hurtbox_component.area_entered.connect(on_hurtbox_area_entered)

func on_hurtbox_area_entered(hurtbox: Area2D) -> void:
	flash(hurtbox)
