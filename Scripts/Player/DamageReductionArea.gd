extends Area2D

@onready var player = get_node("/root/devel/Player")

var enemy_count : int = 0

func _ready():
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Enemy"):
        enemy_count += 1
        player.calculate_punch_count(enemy_count)

func _on_body_exited(body: Node2D) -> void:
    if body.is_in_group("Enemy"):
        enemy_count -= 1
        player.calculate_punch_count(enemy_count)
