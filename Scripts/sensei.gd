extends Sprite2D
class_name Sensei



@onready var label: Label = $Label
@onready var controls: Label = $"../Controls"


var can_trigger_sensei_ui  = false

func _ready() -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	can_trigger_sensei_ui = true
	label.visible = true
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	can_trigger_sensei_ui = false
	label.visible = false
	

func _input(event: InputEvent) -> void:
	var player = get_tree().get_first_node_in_group("player") as MC
		
