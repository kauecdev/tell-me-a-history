extends Label

@onready var game_controller = GameController
@onready var session_controller = SessionController

func _ready():
	var current_player = game_controller.current_player
	var judge = session_controller.current_round.judge
	text = "Turn: " + current_player.name
	if current_player.id == judge.id:
		text += "\n Judge"
