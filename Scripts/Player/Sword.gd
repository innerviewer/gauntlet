extends Area2D
class_name Sword

@export var attack_damage: float = 10.0 
@export var knockback_force: float = 100.0 
@export var stun_time: float = 1.5 
@onready var sword: Sword = $"."

func _ready() -> void:
	sword.monitoring = false
	sword.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		var hurtbox: HurtboxComponent = area
		var attack: Attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = stun_time
		
		hurtbox.flash(area)
		hurtbox.damage(attack)
