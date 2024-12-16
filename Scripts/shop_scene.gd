extends Node

const MAIN_CHARACTER = preload("res://Scenes/main_character.tscn")

@onready var spawn_point: Marker2D = $SpawnPoint
var player = MAIN_CHARACTER.instantiate()
func _ready() -> void:
	self.add_child(player)
	player.health = PlayerState.health
	if PlayerState.inventory:
		for i in PlayerState.inventory.items:
			player.inventory.add_item(i, i.stacks)
	else:
		PlayerState.init_inventory()
		player.inventory.items = PlayerState.inventory.items.duplicate(true)
	TransitionChangeManager.transition_done.connect(on_transition_done)
	if TransitionChangeManager.is_transitioning:
		player.set_physics_process(false)
		player.set_process_input(false)
	
	player.position = spawn_point.position
	
func on_transition_done():
	player.set_physics_process(true)
	player.set_process_input(true)

func _on_exit_area_body_entered(body: Node2D) -> void:
	PlayerState.previous_scene = get_tree().current_scene.name
	if player:
		PlayerState.health = player.health_system.current_health
		PlayerState.inventory.items = player.inventory.items.duplicate(true)
	TransitionChangeManager.change_scene("res://Scenes/level.tscn")
