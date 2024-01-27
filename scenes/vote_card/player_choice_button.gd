extends Button

@onready var game_controller = GameController

var player_id: int

func _on_button_down():
	game_controller.add_score_for_player(player_id)
