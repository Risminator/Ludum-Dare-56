extends Node

enum GAME_SCENES {
	MAIN_MENU,
	START_CUTSCENE,
	MAP,
	RABBIT_LEVEL,
	AXOLOTL_LEVEL,
	MIMIC_LEVEL,
	GOOSE_LEVEL,
	TURTLE_LEVEL,
	HAMSTER_LEVEL,
	ENDING
}

enum FOOD {
	UNDEFINED,
	CARROT,
	MEAT,
	APPLE,
	MANDRAKE,
	FISH,
	BERRIES
}

enum STATES {
	FRIGHTENED,
	IDLE,
	OPEN,
	CHOMP,
	SATISFIED,
	FLEE
}

const MAIN_MENU_PATH = "res://scenes/menus/main_menu.tscn"
const RABBIT_LEVEL_PATH = "res://scenes/levels/rabbit_level.tscn"
const AXOLOTL_LEVEL_PATH = "res://scenes/levels/axolotl_level.tscn"
const MIMIC_LEVEL_PATH = "res://scenes/levels/mimic_level.tscn"
const GOOSE_LEVEL_PATH = "res://scenes/levels/goose_level.tscn"
const TURTLE_LEVEL_PATH = "res://scenes/levels/turtle_level.tscn"
const HAMSTER_LEVEL_PATH = "res://scenes/levels/hamster_level.tscn"
const MAP_PATH = "res://scenes/menus/map.tscn"


var BEATEN_LEVELS = {
	GAME_SCENES.RABBIT_LEVEL: false,
	GAME_SCENES.AXOLOTL_LEVEL: false,
	GAME_SCENES.MIMIC_LEVEL: false,
	GAME_SCENES.GOOSE_LEVEL: false,
	GAME_SCENES.TURTLE_LEVEL: false,
	GAME_SCENES.HAMSTER_LEVEL: false
}

var monsters_count: int = 1
var visited_monsters_count: int = 0

var SoundEffectsVolume = 0
var MusicVolume = 0

#func set_scene(scene_name: String):
	#get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
#
#func set_level_scene(scene_name: String):
	#set_scene("levels/" + scene_name)
#
#func set_menu_scene(scene_name: String):
	#set_scene("menus/" + scene_name)
