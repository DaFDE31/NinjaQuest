extends Node

@onready var main_character: MC = $MainCharacter
@onready var spawn_point: Marker2D = $SpawnPoint

func _ready() -> void:
	
	TransitionChangeManager.transition_done.connect(on_transition_done)
	main_character.position = spawn_point.position
	if TransitionChangeManager.is_transitioning:
		main_character.set_physics_process(false)
		main_character.set_process_input(false)
func on_transition_done():
	main_character.set_physics_process(true)
	main_character.set_process_input(true)
