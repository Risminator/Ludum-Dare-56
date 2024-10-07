extends Node

signal game_start
signal game_win
signal game_lose
signal volume_changed
signal screen_shake
signal speed_limit_reached

signal animal_touched
signal satisfied_animal
signal chomp_successful

signal transition_start(new_scene: Global.GAME_SCENES)
signal transition_complete(new_scene: Global.GAME_SCENES)
