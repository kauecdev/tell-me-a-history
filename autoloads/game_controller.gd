extends Node

@onready var session_controller = SessionController

var players = {}

var current_player: Player
var next_player: Player
var answer_cards: AnswerCards
var questions = Questions
var answers_indexes: Array[int]
var questions_indexes: Array[int]

signal player_removed(player_name: String)

func _ready():
	answer_cards = AnswerCards.new()
	questions = Questions.new()
	
	for i in range(answer_cards.answers.size()):
		answers_indexes.push_back(i)
	for j in range(questions.questions.size()):
		questions_indexes.push_back(j)


func on_add_player(player_name: String):
	var new_player: Player = Player.new()
	new_player.name = player_name
	
	if players.size() > 0:
		var last_id = players.keys().back()
		new_player.id = last_id + 1
	else:
		new_player.id = 1
		
	players[new_player.id] = new_player
	
	return new_player


func on_remove_player(player_id: int):
	var player_name = players[player_id].name
	players.erase(player_id)
	player_removed.emit(player_name)


func on_start_game():
	var judge: Player
	var is_first_round = session_controller.session.rounds.size() == 0
	
	if is_first_round:
		var indexes = players.keys()
		indexes.shuffle()
		judge = players[indexes.pop_front()]
		current_player = judge
	else:
		current_player = next_player
		judge = current_player
		
	var question: Question = pick_question()
	distribute_cards(is_first_round)
	
	session_controller.start_new_round(judge, question) 
	get_tree().change_scene_to_file("res://scenes/question_view/question_view.tscn")
	

func get_next_player():
	var current_player: Player = current_player
	var player_ids: Array = players.keys()
	var current_player_index = player_ids.find(current_player.id)
	next_player = players[1] if current_player_index + 2 > player_ids.size() else players[current_player_index + 2]


func go_to_play_card():
	set_current_player()
	get_tree().change_scene_to_file("res://scenes/play_card/play_card.tscn")


func go_to_confirm_identity():
	get_tree().change_scene_to_file("res://scenes/confirm_identity/confirm_identity.tscn")


func set_current_player():
	current_player = next_player
	
	
func pick_question():
	if not questions_indexes.is_empty():
		questions_indexes.shuffle()
		var random_question: Question = questions.questions[questions_indexes.pop_front()]
		return random_question

func distribute_cards(is_first_round: bool):
	if not answers_indexes.is_empty():
		if is_first_round:
			for i in range(players.size()):
				var player_cards: Array[Card]
				for j in range(5):
					answers_indexes.shuffle()
					var random_card: Card = answer_cards.answers[answers_indexes.pop_front()]
					player_cards.push_back(random_card)
				players[i + 1].cards = player_cards
		else:
			for i in range(players.size()):
				var player: Player = players[i + 1]
				var player_cards: Array[Card] = player.cards
				var players_choices = session_controller.current_round.player_choices
				var players_choices_ids = players_choices.keys()
				
				for j in players_choices_ids:
					if player.id == j:
						var card_id_to_remove = players_choices[j].id
						var new_player_cards = player_cards.filter(func(card: Card): return card.id != card_id_to_remove)
						answers_indexes.shuffle()
						var random_card: Card = answer_cards.answers[answers_indexes.pop_front()]
						new_player_cards.push_back(random_card)
						player.cards = new_player_cards
						


func add_score_for_player(player_id: int, card_id_to_remove: int):
	players[player_id].score += 1
	get_tree().change_scene_to_file("res://scenes/score_board/score_board.tscn")


func go_to_menu():
	session_controller.session = Session.new()
	answers_indexes.clear()
	questions_indexes.clear()
	
	for i in range(answer_cards.answers.size()):
		answers_indexes.push_back(i)
	for j in range(questions.questions.size()):
		questions_indexes.push_back(j)
		
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
