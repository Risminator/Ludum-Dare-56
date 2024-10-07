extends TextureRect

var tip_index: int = 0
var max_tips: int = 6
var tip_length: int = 256
@onready var left_btn: Button = $"../LeftBtn"
@onready var right_btn: Button = $"../RightBtn"

func _ready():
	texture.region.position = Vector2.ZERO
	check_buttons()

func _on_left_btn_pressed() -> void:
	if tip_index > 0:
		tip_index -= 1
		texture.region.position.y = tip_index * tip_length
	check_buttons()

func _on_right_btn_pressed() -> void:
	if tip_index < max_tips - 1:
		tip_index += 1
		texture.region.position.y = tip_index * tip_length
	check_buttons()

func check_buttons() -> void:
	if tip_index <= 0:
		left_btn.disabled = true
	else:
		left_btn.disabled = false
	
	if tip_index >= max_tips - 1:
		right_btn.disabled = true
	else:
		right_btn.disabled = false
