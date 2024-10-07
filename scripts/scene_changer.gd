extends CanvasLayer

var new_scene_path: String
var current_scene: Global.GAME_SCENES

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_to(new_scene: Global.GAME_SCENES):
	print("change_to ", new_scene)
	current_scene = new_scene
	match new_scene:
		Global.GAME_SCENES.MAIN_MENU:
			new_scene_path = Global.MAIN_MENU_PATH
		Global.GAME_SCENES.START_CUTSCENE:
			new_scene_path = Global.START_CUTSCENE_PATH
		Global.GAME_SCENES.MAP:
			new_scene_path = Global.MAP_PATH
		Global.GAME_SCENES.RABBIT_LEVEL:
			new_scene_path = Global.RABBIT_LEVEL_PATH
		Global.GAME_SCENES.AXOLOTL_LEVEL:
			new_scene_path = Global.AXOLOTL_LEVEL_PATH
		Global.GAME_SCENES.MIMIC_LEVEL:
			new_scene_path = Global.MIMIC_LEVEL_PATH
		Global.GAME_SCENES.GOOSE_LEVEL:
			new_scene_path = Global.GOOSE_LEVEL_PATH
		Global.GAME_SCENES.TURTLE_LEVEL:
			new_scene_path = Global.TURTLE_LEVEL_PATH
		Global.GAME_SCENES.HAMSTER_LEVEL:
			new_scene_path = Global.HAMSTER_LEVEL_PATH
		Global.GAME_SCENES.ENDING:
			new_scene_path = Global.ENDING_PATH

	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("fade_in_out")

func restart():
	change_to(current_scene)
	
func _new_scene():
	get_tree().change_scene_to_file.call_deferred(new_scene_path)

func _on_transition_start():
	Events.transition_start.emit(current_scene)

func _on_transition_complete():
	Events.transition_complete.emit(current_scene)
