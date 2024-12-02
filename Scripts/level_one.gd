extends Node

@onready var main_character: MC = $MainCharacter
@onready var spawn_point: Marker2D = $SpawnPoint

func _ready() -> void:
	main_character.position = spawn_point.position
