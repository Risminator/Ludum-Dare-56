extends Node

const SCENES = {
	MAIN = "menus/main_menu",
}

var SoundEffectsVolume = 0
var MusicVolume = 0

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")

func set_level_scene(scene_name: String):
	set_scene("levels/" + scene_name)

func set_menu_scene(scene_name: String):
	set_scene("menus/" + scene_name)
