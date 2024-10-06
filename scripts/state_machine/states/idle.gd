extends State

@export var frightened_state: State
@export var frightened_limit: int = 15

var calm_timer: Timer
var frightened_counter: int = 0
var is_calm = true

func enter() -> void:
	super()
	is_calm = true
	Events.speed_limit_reached.connect(_on_speed_limit_reached)

func exit() -> void:
	Events.speed_limit_reached.disconnect(_on_speed_limit_reached)

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if !is_calm:
		return frightened_state
	return null

func process_physics(_delta: float) -> State:
	return null


func _on_speed_limit_reached() -> void:
	frightened_counter += 1
	if frightened_limit > 0 and frightened_counter >= frightened_limit:
		is_calm = false
		frightened_counter = 0


func _on_touch_collider_body_entered(body: Node2D) -> void:
	is_calm = false
	frightened_counter = 0
