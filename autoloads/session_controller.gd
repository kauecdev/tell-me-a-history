extends Node

@onready var game_controller = GameController

var session: Session = Session.new()

var current_round: Round

func start_new_round(judge: Player, question: Question):
	var new_round: Round = Round.new()
	
	if session.rounds.is_empty():
		new_round.id = 1
	else:
		new_round.id = session.rounds.size() + 1
	
	new_round.judge = judge
	new_round.question = question
	
	session.rounds.push_back(new_round)
	current_round = new_round


func add_player_card(card: Card):
	var current_player = game_controller.current_player
	current_round.player_choices[current_player.id] = card
	
	get_tree().change_scene_to_file("res://scenes/confirm_identity/confirm_identity.tscn")
