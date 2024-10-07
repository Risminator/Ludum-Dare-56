extends Button

@export var level: Global.GAME_SCENES

func _ready():
	if Global.BEATEN_LEVELS[level] == true:
		modulate = Color.hex(0xc38300ff)

func _on_pressed() -> void:
	SceneChanger.change_to(level)
