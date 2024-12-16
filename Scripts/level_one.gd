extends Node

@onready var main_character: MC = $MainCharacter
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var tutorial_spawn: Marker2D = $TutorialSpawn

func _ready() -> void:
	main_character.health = PlayerState.health
	if PlayerState.inventory:
		for i in PlayerState.inventory.items:
			main_character.inventory.add_item(i, i.stacks)
	else:
		PlayerState.init_inventory()
		main_character.inventory.items = PlayerState.inventory.items.duplicate(true)
	TransitionChangeManager.transition_done.connect(on_transition_done)
	if PlayerState.previous_scene == "TutorialScene":
		main_character.position = tutorial_spawn.position
	else:
		main_character.position = spawn_point.position
	if TransitionChangeManager.is_transitioning:
		main_character.set_physics_process(false)
		main_character.set_process_input(false)
func on_transition_done():
	main_character.set_physics_process(true)
	main_character.set_process_input(true)


func _on_shop_area_2d_body_entered(body: Node2D) -> void:
	PlayerState.previous_scene = get_tree().current_scene.name
	if main_character:
		PlayerState.health = main_character.health_system.current_health
		PlayerState.inventory.items = main_character.inventory.items.duplicate(true)
	TransitionChangeManager.change_scene("res://Scenes/shop_scene.tscn")
