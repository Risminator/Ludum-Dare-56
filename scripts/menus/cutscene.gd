extends Node
class_name Cutscene

#@onready var cutscene_frame: Sprite2D = $Container/Frame
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

var frame = 0
var framesN: int

func _ready():
	texture_rect.texture.region.position.x = frame * 1280
	framesN = texture_rect.texture.atlas.get_width() / 1280
	
func _process(_delta):
	if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if frame == framesN - 1:
			SceneChanger.change_to(Global.GAME_SCENES.RABBIT_LEVEL)
		else:
			animation_player.play("fade_transition_forwards")
	if Input.is_action_just_pressed("rmb") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if frame > 0:
			animation_player.play("fade_transition_backwards")

func next_frame() -> void:
	frame += 1
	texture_rect.texture.region.position.x = frame * 1280

func previous_frame() -> void:
	frame -= 1
	texture_rect.texture.region.position.x = frame * 1280
