extends Control

@onready var game_controller = GameController
@onready var session_controller = SessionController
@onready var question_label = $Panel/MarginContainer/VBoxContainer/QuestionLabel
@onready var player_choices_container = $Panel/MarginContainer/VBoxContainer/PlayerChoicesContainer

@export var player_choice_button: PackedScene

func _ready():
	question_label.text = session_controller.current_round.question.text
	
	var player_choices = session_controller.current_round.player_choices
	var player_choices_keys = player_choices.keys()
	
	for i in player_choices_keys:
		var player_choice: Card = player_choices[i]
		var new_player_choice_button = player_choice_button.instantiate()
		var new_node_name = "PlayerChoiceButton" + str(i)
		new_player_choice_button.name = new_node_name
		new_player_choice_button.get_node("PlayerChoiceButton").player_id = i
		new_player_choice_button.get_node("Label").text = player_choice.text
		player_choices_container.add_child(new_player_choice_button)
