extends Resource

class_name InventoryItem

var stacks = 1
@export_enum("Right_Hand", "Left_Hand", "Potions", "Not_Equipable")
var slot_type: String = "Not Equipable"
@export var name: String = ""
@export
var ground_collision_shape: RectangleShape2D
@export var texture: Texture2D
@export var side_texture: Texture2D
@export var max_stacks: int
@export var price: int
