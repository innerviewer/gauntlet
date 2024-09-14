extends Node

@onready var settings_node: CanvasLayer = $MarginContainer/VBoxContainer/Settings/Settings

var are_settings_open: bool = false

func _ready() -> void:
	Events.pause_menu_toggle.connect(pause_menu_toggle)
	
	var settings_color_rect: ColorRect = settings_node.find_child("ColorRect")
	settings_color_rect.color = $ColorRect.color

func _input(event: InputEvent) -> void:
	if self.visible and event.is_action_pressed("ui_cancel"):
		if are_settings_open:
			settings_menu_toggle(false)
		else:
			pause_menu_toggle(false)

func settings_menu_toggle(open: bool) -> void:
	settings_node.visible = open
	settings_node.top_level = open
	are_settings_open = open

func pause_menu_toggle(open: bool) -> void:
	self.visible = open
	get_tree().paused = open

func _on_resume_button_pressed() -> void:
	pause_menu_toggle(false)

func _on_settings_button_pressed() -> void:
	settings_menu_toggle(true)
	
func _on_save_button_pressed() -> void:
	pass
	
func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn") 
	
