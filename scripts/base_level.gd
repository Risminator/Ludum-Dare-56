extends Node2D

@onready var start_timer: Timer = %StartTimer
@onready var start_label: Label = %StartLabel
@onready var hand: CharacterBody2D = %Hand
@onready var start_animation: AnimationPlayer = %StartAnimation

var start_counter: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_label.text = str(start_counter)
	get_tree().paused = true
	Events.transition_complete.connect(_on_transition_complete)
	Events.game_lose.connect(_on_can_restart)
	Events.game_start.connect(_on_can_return_to_map)
	#Events.satisfied_animal.connect(_on_can_restart)

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
		
func _on_transition_complete(new_scene: Global.GAME_SCENES) -> void:
	start_timer.start()

func _on_can_restart() -> void:
	%RestartBtn.disabled = false
	%RestartBtn.visible = true

func _on_can_return_to_map() -> void:
	%ReturnToMapBtn.disabled = false

func _on_return_to_map_btn_pressed() -> void:
	if Global.visited_monsters_count < Global.monsters_count:
		SceneChanger.change_to(Global.GAME_SCENES.MAP)
	else:
		SceneChanger.change_to(Global.GAME_SCENES.ENDING)


func _on_restart_btn_pressed() -> void:
	SceneChanger.restart()
