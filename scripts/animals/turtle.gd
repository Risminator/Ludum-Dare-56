extends Animal
class_name Turtle

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
	Events.satisfied_animal.connect(_on_satisfied_animal)
	
func _on_satisfied_animal() -> void:
	if Global.BEATEN_LEVELS[Global.GAME_SCENES.TURTLE_LEVEL] != true:
		Global.BEATEN_LEVELS[Global.GAME_SCENES.TURTLE_LEVEL] = true
		Global.visited_monsters_count += 1
