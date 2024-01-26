extends Button

@onready var game_controller = GameController

func _ready():
	game_controller.get_next_player()
	text = "Pass to " + game_controller.next_player.name
