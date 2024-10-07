extends AudioStreamPlayer2D

@onready var st = stream as AudioStreamInteractive

enum LOCATION_MUSIC_IDS {
	CUTSCENE = 0,
	CUTSCENE_VAR = 1,
	MAP = 0,
	MAP_VAR = 1,
	MOUNTAINS = 2,
	MOUNTAINS_VAR = 3,
	RIVER = 4,
	RIVER_VAR = 5,
	FOREST = 6,
	FOREST_VAR = 7,
	ALL = 8,
	ALL_VAR = 9,
	MENU = 8,
	MENU_VAR = 9,
	ENDING = 9,
	ENDING_VAR = 9
}

var current_track_id: int = 0
var is_satisfied: bool = false

var music_ids = {
	Global.GAME_SCENES.MAIN_MENU: LOCATION_MUSIC_IDS.MENU,
	Global.GAME_SCENES.MAP: LOCATION_MUSIC_IDS.MAP,
	Global.GAME_SCENES.START_CUTSCENE: LOCATION_MUSIC_IDS.CUTSCENE,
	Global.GAME_SCENES.ENDING: LOCATION_MUSIC_IDS.ENDING,
	
	Global.GAME_SCENES.RABBIT_LEVEL: LOCATION_MUSIC_IDS.MOUNTAINS,
	Global.GAME_SCENES.MIMIC_LEVEL: LOCATION_MUSIC_IDS.MOUNTAINS,
	Global.GAME_SCENES.AXOLOTL_LEVEL: LOCATION_MUSIC_IDS.RIVER,
	Global.GAME_SCENES.GOOSE_LEVEL: LOCATION_MUSIC_IDS.RIVER,
	Global.GAME_SCENES.TURTLE_LEVEL: LOCATION_MUSIC_IDS.FOREST,
	Global.GAME_SCENES.HAMSTER_LEVEL: LOCATION_MUSIC_IDS.FOREST
}

const music_var_ids = {
	Global.GAME_SCENES.MAIN_MENU: LOCATION_MUSIC_IDS.MENU_VAR,
	Global.GAME_SCENES.MAP: LOCATION_MUSIC_IDS.MAP_VAR,
	Global.GAME_SCENES.START_CUTSCENE: LOCATION_MUSIC_IDS.CUTSCENE_VAR,
	Global.GAME_SCENES.ENDING: LOCATION_MUSIC_IDS.ENDING_VAR,
	
	Global.GAME_SCENES.RABBIT_LEVEL: LOCATION_MUSIC_IDS.MOUNTAINS_VAR,
	Global.GAME_SCENES.MIMIC_LEVEL: LOCATION_MUSIC_IDS.MOUNTAINS_VAR,
	Global.GAME_SCENES.AXOLOTL_LEVEL: LOCATION_MUSIC_IDS.RIVER_VAR,
	Global.GAME_SCENES.GOOSE_LEVEL: LOCATION_MUSIC_IDS.RIVER_VAR,
	Global.GAME_SCENES.TURTLE_LEVEL: LOCATION_MUSIC_IDS.FOREST_VAR,
	Global.GAME_SCENES.HAMSTER_LEVEL: LOCATION_MUSIC_IDS.FOREST_VAR
}

func _change_to_base() -> void:
	is_satisfied = false
	var playback = get_stream_playback()
	if (!is_satisfied && current_track_id % 2 > 0):
		playback.switch_to_clip(current_track_id - 1)

func _change_to_var() -> void:
	is_satisfied = true
	var playback = get_stream_playback()
	if (is_satisfied && current_track_id % 2 == 0):
		playback.switch_to_clip(current_track_id + 1)

func _inital_music(track: LOCATION_MUSIC_IDS) -> void:
	var playback = get_stream_playback()
	if playback:
		playback.switch_to_clip(track)

func _ready() -> void:
	play()
	_inital_music(LOCATION_MUSIC_IDS.MENU)
	Events.transition_start.connect(_on_transition_start)
	Events.satisfied_animal.connect(_change_to_var)
	Events.game_lose.connect(_change_to_base)

func _process(delta: float) -> void:
	pass

func _on_transition_start(new_scene: Global.GAME_SCENES) -> void:
	var playback = get_stream_playback()
	
	var music_id = music_ids.get(new_scene, null)
	var music_var_id = music_var_ids.get(new_scene, null)
	
	if is_satisfied and music_var_id:
		current_track_id = music_var_id
		playback.switch_to_clip(music_var_id)
	elif music_id || music_id == 0:
		current_track_id = music_id
		playback.switch_to_clip(music_id)
