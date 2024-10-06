extends State

@export var chomp_state: State
var chomp_timer: Timer

var chomp_ready: bool = false

func enter() -> void:
	super()
	chomp_ready = false
	chomp_timer = parent.chomp_timer
	chomp_timer.timeout.connect(_on_chomp_timer_timeout)
	chomp_timer.start()
	
	
func exit() -> void:
	chomp_ready = false
	chomp_timer.timeout.disconnect(_on_chomp_timer_timeout)

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if chomp_ready:
		return chomp_state
	return null

func process_physics(_delta: float) -> State:
	return null
	
	
func _on_chomp_timer_timeout() -> void:
	chomp_ready = true
