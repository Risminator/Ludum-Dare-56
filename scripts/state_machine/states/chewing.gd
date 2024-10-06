extends State

@export var idle_state: State
@export var satisfied_state: State
var satisfied: bool = false
var finished_chomp: bool = false

func enter() -> void:
	super()
	parent.chomp_timer.timeout.connect(_on_chomp_timer_timeout)
	Events.satisfied_animal.connect(_on_satsified)

func exit() -> void:
	parent.chomp_timer.timeout.disconnect(_on_chomp_timer_timeout)
	#Events.satisfied_animal.disconnect(_on_satsified)

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	if satisfied:
		return satisfied_state
	if finished_chomp:
		return idle_state
	return null

func process_physics(_delta: float) -> State:
	return null

func _on_satsified():
	satisfied = true

func _on_chomp_timer_timeout():
	finished_chomp = true
