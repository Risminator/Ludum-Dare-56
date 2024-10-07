extends TextureRect

var tip_index: int = 0
var max_tips: int = 6
var tip_length: int = 256

func _ready():
	texture.region.position = Vector2.ZERO

func _on_left_btn_pressed() -> void:
	if tip_index > 0:
		tip_index -= 1
		texture.region.position.y = tip_index * tip_length

func _on_right_btn_pressed() -> void:
	if tip_index < max_tips - 1:
		tip_index += 1
		texture.region.position.y = tip_index * tip_length
