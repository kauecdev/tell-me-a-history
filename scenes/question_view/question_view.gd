extends Control

@onready var game_controller = GameController
@onready var session_controller = SessionController
@onready var player_name_label = $Panel/MarginContainer/PlayerNameLabel
@onready var pass_to_player_button = $Panel/MarginContainer/PassToPlayerButton
@onready var question_label = $Panel/MarginContainer/QuestionLabel

func _ready():
	question_label.text = session_controller.current_round.question.text


func _on_pass_to_player_button_button_down():
	game_controller.go_to_confirm_identity()
