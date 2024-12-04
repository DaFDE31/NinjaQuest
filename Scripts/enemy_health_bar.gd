extends ProgressBar

class_name EnemyHealthBar

@onready var health_system: HealthSystem = $"../HealthSystem"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	max_value = health_system.max_health
	value = max_value
	health_system.damage_taken.connect(on_damage_taken)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_damage_taken(damage: int):
	if !visible:
		visible = true
	value -= damage
