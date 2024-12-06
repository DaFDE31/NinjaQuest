extends Node

var health: int = 12
var inventory: Inventory = null
var previous_scene: String = ""
func init_inventory():
	if inventory == null:
		inventory = Inventory.new()
