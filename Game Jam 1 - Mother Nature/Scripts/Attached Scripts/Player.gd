extends KinematicBody2D

const ACCELERATION : int = 200
const MAX_SPEED : int = 100

var move_direction = [input_vector.x > 0, input_vector.y > 0]

var input_vector := Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	move()
	
func move():
	
	var action_pressed := ""
	
	if velocity != Vector2.ZERO:
		
		match move_direction:
			
			[true, true]: #Direita
				pass
	
	move_and_collide(velocity)
