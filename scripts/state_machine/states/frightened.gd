extends State

@export var idle_state: State
@export var flee_limit: int = 25

var calm_timer: Timer
var flee_counter: int = 0
var is_calm = false
#var mutex: Mutex = Mutex.new()

func enter() -> void:
	super()
	calm_timer = parent.calm_timer
	flee_counter = 0
	is_calm = false
	calm_timer.timeout.connect(_on_calm_timer_timeout)
	calm_timer.start()
	
	Events.speed_limit_reached.connect(_on_speed_limit_reached)
	parent.touch_collider.body_entered.connect(_on_touch_collider_body_entered)

func exit() -> void:
	if flee_limit > 0:
		Events.speed_limit_reached.disconnect(_on_speed_limit_reached)
	is_calm = true
	calm_timer.timeout.disconnect(_on_calm_timer_timeout)
	calm_timer.stop()

	parent.touch_collider.body_entered.disconnect(_on_touch_collider_body_entered)


func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if is_calm:
		return idle_state
	return null

func process_physics(_delta: float) -> State:
	return null

# SIGNALS

func _on_speed_limit_reached() -> void:
	flee_counter += 1
	calm_timer.stop()
	calm_timer.start()
	if flee_limit > 0 and flee_counter >= flee_limit and parent.cooldown_timer.is_stopped():
		parent.flee()

func _on_calm_timer_timeout() -> void:
	is_calm = true
	flee_counter = 0


func _on_touch_collider_body_entered(body: Node2D) -> void:
	if parent.cooldown_timer.is_stopped():
		parent.flee()
