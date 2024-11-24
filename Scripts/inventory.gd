extends Node

class_name Inventory

@onready var inventory_ui: CanvasLayer = $"../InventoryUI"
@onready var on_screen_ui: OnScreenUI = $"../OnScreenUI"
@onready var combat_system: CombatSystem = $"../CombatSystem"

@export var items: Array[InventoryItem] = [] # inventory of items
func _ready() -> void:
	inventory_ui.equip_item.connect(on_item_equipped)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		inventory_ui.toggle()
		
func add_item(item: InventoryItem, stacks: int):
	if stacks && item.max_stacks > 1:
		add_stackable_item_to_inventory(item, stacks)
	else:
		items.append(item)
		inventory_ui.add_item(item)
		# TODO update the player UI to have the item there.

func add_stackable_item_to_inventory(item: InventoryItem, stacks: int):
	var item_index = -1
	for i in items.size():
		if items[i] != null and items[i].name == item.name:
			item_index = i
	if item_index != -1:
		var inventory_item = items[item_index]
		# Stacks really should be called stackcount or something but too late to change now
		if inventory_item.stacks + stacks <= item.max_stacks:
			inventory_item.stacks += stacks
			items[item_index] = inventory_item
			inventory_ui.update_stack_at_slot_index(inventory_item.stacks, item_index)
		else:
			'''
			var stack_diff = inventory_item.stacks + stacks - item.max_stacks
			var new_inventory_item = inventory_item.duplicate(true)
			inventory_item.stacks = item.max_stacks
			new_inventory_item.stacks = stack_diff
			'''
			var new_inventory_item = inventory_item.duplicate(true)
			new_inventory_item.stacks = inventory_item.stacks + stacks - item.max_stacks
			inventory_item.stacks = item.max_stacks
			inventory_ui.update_stack_at_slot_index(inventory_item.max_stacks, item_index)
			items.append(new_inventory_item)
			inventory_ui.add_item(new_inventory_item)
			
	else:
		item.stacks = stacks
		items.append(item)
		inventory_ui.add_item(item)

func on_item_equipped(idx: int, slot_to_equip: String):
	var item_to_equip = items[idx]
	on_screen_ui.equip_item(item_to_equip,slot_to_equip)
	combat_system.set_active_weapon(item_to_equip.weapon_item, slot_to_equip)
