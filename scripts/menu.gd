extends Control
@onready var v_box: VBoxContainer = $VBoxContainer

func _ready():
	v_box.grab_focus()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
