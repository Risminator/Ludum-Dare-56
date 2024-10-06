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
		Global.GAME_SCENES.RABBIT_LEVEL:
			new_scene_path = Global.RABBIT_LEVEL_PATH
		Global.GAME_SCENES.MAP:
			new_scene_path = Global.MAP_PATH
	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("fade_in_out")

func restart():
	change_to(current_scene)
	
func _new_scene():
	get_tree().change_scene_to_file.call_deferred(new_scene_path)

func _on_transition_complete():
	Events.transition_complete.emit()
