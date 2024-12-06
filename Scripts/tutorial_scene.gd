extends Node

const MAIN_CHARACTER = preload("res://Scenes/main_character.tscn")

@onready var spawn_point: Marker2D = $SpawnPoint
var player = MAIN_CHARACTER.instantiate()
func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	PlayerState.init_inventory()
	player.init_inventory()
	player.inventory.items = PlayerState.inventory.items.duplicate(true)
	self.add_child(player)
	if TransitionChangeManager.is_transitioning:
		#player.set_physics_process(false)
		#player.set_process_input(false)
		pass
	player.position = spawn_point.position
	#player.setup_test_inventory()
	
func on_transition_done():
	$".".set_physics_process(true)
	$".".set_process_input(true)

func _on_exit_area_body_entered(body: Node2D) -> void:
	PlayerState.previous_scene = get_tree().current_scene.name
	print_debug(PlayerState.previous_scene)
	if player:
		PlayerState.health = player.health_system.current_health
		PlayerState.inventory.items = player.inventory.items.duplicate(true)
		print_debug(PlayerState.health)
		print_debug(PlayerState.inventory.items)
	TransitionChangeManager.change_scene("res://Scenes/level.tscn")
