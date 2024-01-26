extends HBoxContainer

var player: Player

@onready var game_controller = GameController

func set_player(new_player: Player):
	player = new_player

func _on_remove_player_button_pressed():
	game_controller.on_remove_player(player.id)
