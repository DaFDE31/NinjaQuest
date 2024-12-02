extends Node

const MAIN_CHARACTER = preload("res://Scenes/main_character.tscn")

@onready var spawn_point: Marker2D = $"../SpawnPoint"

func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	var player = MAIN_CHARACTER.instantiate()
	self.add_child(player)
	player.position = spawn_point.position
	
func on_transition_done():
	$".".set_physics_process(true)



func _on_exit_area_body_entered(body: Node2D) -> void:
	TransitionChangeManager.change_scene("res://Scenes/level.tscn")
