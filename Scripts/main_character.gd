extends CharacterBody2D


const SPEED = 7000.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x , 0, SPEED * delta)
		velocity.y = move_toward(velocity.y , 0, SPEED * delta)
	move_and_slide()
