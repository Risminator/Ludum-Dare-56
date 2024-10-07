extends State

func enter() -> void:
	super()
	parent.gpu_particles_2d.emitting = true
	parent.physical_collider.disabled = false

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
