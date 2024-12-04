extends CharacterBody2D

class_name Enemy

@export var speed: float = 50
@export var patrol_path: Array[Marker2D] = []
@export var patrol_wait_time = 1.0
@export var damage_to_player = 10

@export var health: int = 50
@export var item_to_drop: InventoryItem
@export var loot_stacks = 1

@onready var animated_sprite_2d: EnemyAnimation = $AnimatedSprite2D
@onready var health_system: HealthSystem = $HealthSystem
@onready var health_bar: ProgressBar = $HealthBar
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


const PICK_UP_ITEM = preload("res://Scenes/pick_up_item.tscn")

var current_patrol_target = 0
var wait_timer = 0.0

func _ready() -> void:
	health_system.init(health)
	health_bar.max_value = health
	health_bar.value = health
	
	if patrol_path.size() > 0:
		position = patrol_path[0].position
	health_system.died.connect(on_death)

func _physics_process(delta: float) -> void:
	if patrol_path.size() > 1:
		move_along_path(delta)

func move_along_path(delta: float):
	var target_position = patrol_path[current_patrol_target].global_position
	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_to(target_position)
	
	if distance_to_target > speed * delta:
		animated_sprite_2d.play_movement_animation(direction)
		velocity = direction * speed
		move_and_slide()
	else:
		animated_sprite_2d.play_idle_animation()
		position = target_position
		wait_timer += delta
		if wait_timer >= patrol_wait_time:
			wait_timer = 0.0
			current_patrol_target = (current_patrol_target + 1) % patrol_path.size()
func apply_damage(damage: int):
	health_system.apply_damage(damage)

func on_death():
	set_physics_process(false)
	collision_shape_2d.set_deferred("disbaled", true)
	area_collision_shape_2d.set_deferred("disbaled", true)
	animated_sprite_2d.play("death")
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		var loot_drop = PICK_UP_ITEM.instantiate() as PickUpItem
		loot_drop.inventory_item = item_to_drop
		loot_drop.stacks = loot_stacks
		
		get_tree().root.add_child(loot_drop)
		loot_drop.global_position = position
		queue_free()
