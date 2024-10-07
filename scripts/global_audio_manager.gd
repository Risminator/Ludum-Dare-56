extends AudioStreamPlayer2D

@onready var st = stream as AudioStreamInteractive

const NORMAL_VOLUME := 0
const MUTE_VOLUME := -60

enum LOCATION_MUSIC_IDS {
	MENU = 0,
	MENU_VAR = 1,
	MAP = 0,
	MAP_VAR = 1,
	MOUNTAINS = 2,
	MOUNTAINS_VAR = 3,
	FOREST = 4,
	FOREST_VAR = 5,
	RIVER = 4,
	RIVER_VAR = 5,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Events.transition_start.connect(_on_transition_start)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_transition_start(new_scene: Global.GAME_SCENES) -> void:
	print('now playing:')
	
	var playback = get_stream_playback()
	
	match new_scene:
		Global.GAME_SCENES.MAIN_MENU:
			playback.switch_to_clip(LOCATION_MUSIC_IDS.MENU)
		Global.GAME_SCENES.RABBIT_LEVEL:
			playback.switch_to_clip(LOCATION_MUSIC_IDS.MOUNTAINS)
		Global.GAME_SCENES.MAP:
			playback.switch_to_clip(LOCATION_MUSIC_IDS.MAP)
	print(new_scene)
