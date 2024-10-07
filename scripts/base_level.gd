extends Node2D

@onready var start_timer: Timer = %StartTimer
@onready var start_label: Label = %StartLabel
@onready var hand: CharacterBody2D = %Hand
@onready var start_animation: AnimationPlayer = %StartAnimation
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var start_counter: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_label.text = str(start_counter)
	get_tree().paused = true
	Events.transition_complete.connect(_on_transition_complete)
	audio_stream_player_2d.play()
	Events.game_lose.connect(_on_can_return_to_map)
	Events.satisfied_animal.connect(_on_can_return_to_map)


func _on_start_timer_timeout() -> void:
	start_counter -= 1
	if start_counter > 0:
		start_label.text = str(start_counter)
		start_timer.start()
	else:
		start_label.text = "Go!"
	start_animation.play("AppearDisappear")
	
func start_game() -> void:
	if start_counter <= 0:
		get_tree().paused = false
		Events.game_start.emit()
		
func _on_transition_complete() -> void:
	start_timer.start()

func _on_can_return_to_map() -> void:
	%ReturnToMapBtn.disabled = false
	%RestartBtn.disabled = false
	%RestartBtn.visible = true

func _on_return_to_map_btn_pressed() -> void:
	SceneChanger.change_to(Global.GAME_SCENES.MAP)


func _on_restart_btn_pressed() -> void:
	SceneChanger.restart()
