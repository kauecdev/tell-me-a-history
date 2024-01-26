extends Control

@onready var game_controller = GameController
@onready var session_controller = SessionController
@onready var i_am_player_button = $Panel/MarginContainer/IAmPlayerButton

func _ready():
	game_controller.get_next_player()
	game_controller.set_current_player()
	i_am_player_button.text = "I am " + game_controller.current_player.name


func _on_i_am_player_button_button_down():
	if game_controller.current_player.id != session_controller.current_round.judge.id:
		game_controller.go_to_play_card()
	else:
		get_tree().change_scene_to_file("res://scenes/vote_card/vote_card.tscn")
