extends State

@export var frightened_state: State
@export var open_state: State
@export var frightened_limit: int = 15

@onready var calm_timer: Timer
var frightened_counter: int = 0

enum AVAILABLE_STATES {
	Frightened,
	Idle,
	Open
}

var current_state: AVAILABLE_STATES = AVAILABLE_STATES.Idle

func enter() -> void:
	super()
	current_state = AVAILABLE_STATES.Idle
	Events.speed_limit_reached.connect(_on_speed_limit_reached)
	calm_timer = parent.calm_timer
	calm_timer.timeout.connect(_on_calm_timer_timeout)
	calm_timer.start()
	
	parent.touch_collider.body_entered.connect(_on_touch_collider_body_entered)

func exit() -> void:
	Events.speed_limit_reached.disconnect(_on_speed_limit_reached)
	calm_timer.timeout.disconnect(_on_calm_timer_timeout)
	parent.touch_collider.body_entered.disconnect(_on_touch_collider_body_entered)


func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	match current_state:
		AVAILABLE_STATES.Frightened:
			parent.cooldown_timer.start()
			return frightened_state
		AVAILABLE_STATES.Open:
			return open_state
	return null

func process_physics(_delta: float) -> State:
	return null


func _on_speed_limit_reached() -> void:
	frightened_counter += 1
	if frightened_limit > 0 and frightened_counter >= frightened_limit and parent.cooldown_timer.is_stopped():
		current_state = AVAILABLE_STATES.Frightened
		frightened_counter = 0


func _on_touch_collider_body_entered(body: Node2D) -> void:
	if parent.cooldown_timer.is_stopped():
		current_state = AVAILABLE_STATES.Frightened
		frightened_counter = 0


func _on_calm_timer_timeout() -> void:
	current_state = AVAILABLE_STATES.Open
