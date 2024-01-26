extends Control

@onready var game_controller = GameController
@onready var session_controller = SessionController
@onready var question_label = $Panel/MarginContainer/VBoxContainer/QuestionLabel
@onready var cards_container = $Panel/MarginContainer/VBoxContainer/CardsContainer

@export var card_button: PackedScene

func _ready():
	question_label.text = session_controller.current_round.question.text
	
	var current_player = game_controller.current_player
	
	for i in range(current_player.cards.size()):
		var player_card: Card = current_player.cards[i]
		var new_card_button = card_button.instantiate()
		var new_node_name = "CardButton" + str(player_card.id)
		new_card_button.name = new_node_name
		new_card_button.get_node("CardButton").card = player_card
		new_card_button.get_node("Label").text = player_card.text
		cards_container.add_child(new_card_button)
	
