extends Control

func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://scenes/create_players/create_players.tscn")


func _on_rules_button_button_down():
	get_tree().change_scene_to_file("res://scenes/rules/rules.tscn")
