extends Control

@onready var game_controller = GameController
@onready var player_names = $Panel/MarginContainer/VBoxContainer/PlayerNames
@onready var player_name_input = $Panel/MarginContainer/VBoxContainer/HBoxContainer/PlayerNameInput
@onready var start_button = $Panel/MarginContainer/CanvasLayer/StartButton
@onready var add_player_button = $Panel/MarginContainer/VBoxContainer/HBoxContainer/AddPlayerButton

@export var PLAYER_CREATED: PackedScene

func _ready():
	game_controller.player_removed.connect(on_player_removed)
	start_button.disabled = true
	add_player_button.disabled = true
	

func on_player_removed(player_name: String):
	player_names.get_node(player_name).queue_free()
	
	if game_controller.players.size() < 5:
		add_player_button.disabled = false
	

func _on_add_player_button_button_down():
	var new_player_name = player_name_input.text
	var new_player = game_controller.on_add_player(new_player_name)
	
	var new_player_created = PLAYER_CREATED.instantiate()
	new_player_created.name = new_player_name
	new_player_created.get_node("Name").text = new_player_name
	new_player_created.set_player(new_player)
	
	player_names.add_child(new_player_created)
	player_name_input.clear()
	
	if game_controller.players.size() >= 3:
		start_button.disabled = false
		
	if game_controller.players.size() == 5:
		add_player_button.disabled = true


func _on_player_name_input_text_changed(new_text):
	if player_name_input.text.length() > 0:
		add_player_button.disabled = false
	else:
		add_player_button.disabled = true


func _on_start_button_button_down():
	game_controller.on_start_game()
