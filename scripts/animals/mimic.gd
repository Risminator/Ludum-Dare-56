extends Animal
class_name Mimic
@onready var move_animation: AnimationPlayer = $MoveAnimation

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	gpu_particles_2d.process_material = Global.particles
	angry_gpu_particles_2d.process_material = Global.particles
	state_machine.init(self)
	Events.satisfied_animal.connect(_on_satisfied_animal)
	
func _on_satisfied_animal() -> void:
	if Global.BEATEN_LEVELS[Global.GAME_SCENES.MIMIC_LEVEL] != true:
		Global.BEATEN_LEVELS[Global.GAME_SCENES.MIMIC_LEVEL] = true
		Global.visited_monsters_count += 1
	move_animation.play("idle")
