extends CanvasLayer

var new_scene_path: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_to(new_scene: Global.GAME_SCENES):
	print("change_to ", new_scene)
	match new_scene:
		Global.GAME_SCENES.MAIN_MENU:
			new_scene_path = Global.MAIN_MENU_PATH
		Global.GAME_SCENES.GAME:
			new_scene_path = Global.GAME_PATH
	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("fade_in_out")
	
func _new_scene():
	get_tree().change_scene_to_file.call_deferred(new_scene_path)
