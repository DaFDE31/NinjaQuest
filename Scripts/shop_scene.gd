extends Node

const MAIN_CHARACTER = preload("res://Scenes/main_character.tscn")

@onready var spawn_point: Marker2D = $SpawnPoint

func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	var player = MAIN_CHARACTER.instantiate()
	self.add_child(player)
	if TransitionChangeManager.is_transitioning:
		#player.set_physics_process(false)
		#player.set_process_input(false)
		pass
	player.position = spawn_point.position
	player.setup_test_inventory()
	
func on_transition_done():
	$".".set_physics_process(true)
	$".".set_process_input(true)

func _on_exit_area_body_entered(body: Node2D) -> void:
	PlayerState.previous_scene = get_tree().current_scene.name
	TransitionChangeManager.change_scene("res://Scenes/level.tscn")
