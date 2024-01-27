extends Control

@onready var game_controller = GameController
@onready var session_controller = SessionController
@onready var player_names = $Panel/MarginContainer/VBoxContainer/PlayerNames
@onready var next_round_button = $Panel/MarginContainer/CanvasLayer/NextRoundButton
@onready var menu_button = $Panel/MarginContainer/CanvasLayer/MenuButton
@onready var win_message = $Panel/MarginContainer/VBoxContainer/WinMessage

func _ready():
	var players = game_controller.players
	var players_ids = players.keys()
	
	game_controller.get_next_player()
	
	var player_winner: Player
	
	for i in players_ids:
		var player_name_label = Label.new()
		player_name_label.add_theme_font_size_override("font_size", 80)
		player_name_label.text = players[i].name + ": "+ str(players[i].score) + " pts"
		player_names.add_child(player_name_label)
		
		if players[i].score == 3:
			player_winner = players[i]
	
	if player_winner != null:
		next_round_button.visible = false
		menu_button.visible = true
		win_message.visible = true
		win_message.text = player_winner.name + " wins!"
	else:
		next_round_button.text = "Next Round: " + game_controller.next_player.name
	
	
func _on_next_round_button_button_down():
	game_controller.on_start_game()


func _on_menu_button_button_down():
	game_controller.go_to_menu()
