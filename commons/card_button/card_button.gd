extends Button

@onready var session_controller = SessionController

var card: Card

func _on_button_down():
	session_controller.add_player_card(card)
