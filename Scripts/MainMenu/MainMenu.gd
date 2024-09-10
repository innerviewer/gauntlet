extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var exit_button = $VBoxContainer/ExitButton

func _ready():
    start_button.connect("pressed", Callable(self, "_on_StartButton_pressed"))
    settings_button.connect("pressed", Callable(self, "_on_SettingsButton_pressed"))
    exit_button.connect("pressed", Callable(self, "_on_ExitButton_pressed"))
    
func _on_StartButton_pressed():
    get_tree().change_scene_to_file("res://Levels/devel.tscn")  

func _on_SettingsButton_pressed():
    pass

func _on_ExitButton_pressed():
    get_tree().quit()
