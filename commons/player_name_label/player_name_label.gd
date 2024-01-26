extends Label

@onready var game_controller = GameController

func _ready():
	text = "Turn: " + game_controller.current_player.name
