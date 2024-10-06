extends State

@export var idle_state: State
@export var chewing_state: State
@export var satisfied_state: State
var satisfied: bool = false

var finished_chomp: bool = false

func enter() -> void:
	super()
	finished_chomp = false
	parent.chomp_timer.timeout.connect(_on_chomp_timer_timeout)
	Events.satisfied_animal.connect(_on_satsified)
	parent.chomp_timer.start()

func exit() -> void:
	parent.chomp_timer.timeout.disconnect(_on_chomp_timer_timeout)
	Events.satisfied_animal.disconnect(_on_satsified)

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if finished_chomp:
		return idle_state
	if satisfied:
		return satisfied_state
	return null

func process_physics(_delta: float) -> State:
	return null

func _on_chomp_timer_timeout():
	finished_chomp = true
	
func _on_satsified():
	satisfied = true
