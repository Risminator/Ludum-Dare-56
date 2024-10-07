extends Node

enum GAME_SCENES {
	MAIN_MENU,
	RABBIT_LEVEL,
	MAP
}

enum FOOD {
	UNDEFINED,
	CARROT,
	MEAT,
	APPLE,
	MANDRAKE,
	FISH
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
const MAP_PATH = "res://scenes/menus/map.tscn"


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
