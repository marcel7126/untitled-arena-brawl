extends Node

const WIN_CONDITION = {
	"ROUND_WINS": "rounds",
	"LAST_ONE_STANDING": "last",
	"TIME_LIMIT": "timer",
}

const defaults = {
	"best_of_rounds": {
		"win_condition": WIN_CONDITION.ROUND_WINS,
		"round_winds": 3,
	},
	"battle_royale": {
		"win_condition": WIN_CONDITION.LAST_ONE_STANDING,
	},
	"deathmatch": {
		"win_condition": WIN_CONDITION.TIME_LIMIT,
		"time_limit": 1 * 60 * 10
	}
}

var game_loop_structure
var game_loop
var is_running = false

var ui

func set_game_loop_structure(preset):
	game_loop_structure = defaults[preset]
	
	load_ui()

func start_game_loop():
	is_running = true

func load_ui():
	if game_loop_structure.win_condition == WIN_CONDITION.ROUND_WINS:
		var ui_instance = load("res://NEW/ROUNDS.tscn").instance()
		$"../Menus/MENU/INGAME".add_child(ui_instance)
		ui = ui_instance
	if game_loop_structure.win_condition == WIN_CONDITION.LAST_ONE_STANDING:
		pass
		#load br ui / no ui
	if game_loop_structure.win_condition == WIN_CONDITION.TIME_LIMIT:
		pass
		#load deathmatch ui / timer ui






