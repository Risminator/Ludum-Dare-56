extends Button


func _on_pressed() -> void:
	SceneChanger.change_to(Global.GAME_SCENES.TEST_LEVEL)
