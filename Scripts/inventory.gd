extends Node

class_name Inventory

@onready var inventory_ui: CanvasLayer = $"../InventoryUI"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		inventory_ui.toggle()
