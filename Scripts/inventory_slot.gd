extends VBoxContainer
class_name InventorySlot

var is_empty = true
var is_selected = false
var slot_to_equip = "Not_Equipable"

@export var single_button_press = false
@export var starting_texture: Texture
@export var start_label: String

@onready var texture_rect: TextureRect = $NinePatchRect/MenuButton/CenterContainer/TextureRect
@onready var stacks: Label = $NinePatchRect/Stacks
@onready var on_click_button: Button = $NinePatchRect/OnClickButton
@onready var price: Label = $Price
@onready var name_label: Label = $NameLabel
@onready var menu_button: MenuButton = $NinePatchRect/MenuButton

func _ready() -> void:
	if starting_texture != null:
		texture_rect.texture = starting_texture
	if start_label != null:
		name_label.text = start_label
	menu_button.disabled = single_button_press
	on_click_button.disabled = !single_button_press
	
	on_click_button.visible = single_button_press
	
	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(on_popup_menu_item_pressed)
	
func on_popup_menu_item_pressed(id: int):
	print_debug(id)
	
	
