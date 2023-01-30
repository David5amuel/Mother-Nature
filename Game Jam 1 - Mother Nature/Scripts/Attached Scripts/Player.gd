extends KinematicBody2D

const SPEED : int = 200

onready var wallDetectorOffset = $WallDetectorOffset
onready var wallDetector = $WallDetectorOffset/WallDetector
onready var collisionShape = $CollisionShape2D

enum {
	RIGHT,
	LEFT,
	UP,
	DOWN,
	NONE
}

var direction = NONE

var input_vector := Vector2.ZERO
var velocity := Vector2.ZERO
var moving := false

func _physics_process(delta):
	print(wallDetector.monitoring)
	action_pressed()
	
	match direction:
		DOWN:
			move(0, SPEED)
		UP:
			move(0, -SPEED)
		LEFT:
			move(-SPEED, 0)
		RIGHT:
			move(SPEED, 0)
		NONE:
			move(0, 0)
			
func move(x : int, y : int):
	
	velocity.x = x
	velocity.y = y
	
	move_and_slide(velocity)

func action_pressed():
	
	if velocity == Vector2.ZERO:
		
		if Input.is_action_pressed("move_down"):
			collisionShape.rotation_degrees = 180
			wallDetectorOffset.rotation_degrees = 180
			wallDetector.set_deferred("monitoring", true)
			moving = true
			direction = DOWN
			
		if Input.is_action_pressed("move_left"):
			collisionShape.rotation_degrees = 270
			wallDetectorOffset.rotation_degrees = 270
			wallDetector.set_deferred("monitoring", true)
			moving = true
			direction = LEFT
			
		if Input.is_action_pressed("move_right"):
			collisionShape.rotation_degrees = 90
			wallDetectorOffset.rotation_degrees = 90
			wallDetector.set_deferred("monitoring", true)
			moving = true
			direction = RIGHT
			
		if Input.is_action_pressed("move_up"):
			collisionShape.rotation_degrees = 0
			wallDetectorOffset.rotation_degrees = 0
			wallDetector.set_deferred("monitoring", true)
			moving = true			
			direction = UP
			
	if moving == false:
		direction = NONE

func _on_WallDetector_body_entered(body):
	moving = false
	wallDetector.set_deferred("monitoring", false)
