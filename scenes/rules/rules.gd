extends Control

func _on_back_button_button_down():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
