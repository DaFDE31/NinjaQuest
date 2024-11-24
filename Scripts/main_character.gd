extends CharacterBody2D
class_name MC
var SPEED = 7000.0
@onready var animated_sprite_2d: AnimationController = $AnimatedSprite2D
@onready var inventory: Inventory = $Inventory


func _physics_process(delta: float) -> void:
	if animated_sprite_2d.animation.contains("attack"):
		return
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x , 0, SPEED * delta)
		velocity.y = move_toward(velocity.y , 0, SPEED * delta)
		
	if velocity != Vector2.ZERO:
		animated_sprite_2d.play_movement_animation(velocity)
	else:
		animated_sprite_2d.play_idle_animation()
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is PickUpItem:
		inventory.add_item(area.inventory_item, area.stacks)
		area.queue_free()
