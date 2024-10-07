extends Button

@export var food: Global.FOOD


func _on_pressed() -> void:
	if %Hand.hp >= %Hand.max_hp:
		%Hand.food = food
		%Hand.animation_player.play("{food} {health} hp".format({"food":food, "health":%Hand.hp}))
