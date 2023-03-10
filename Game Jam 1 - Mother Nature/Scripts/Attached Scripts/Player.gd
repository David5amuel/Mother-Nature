extends KinematicBody2D

const SPEED : int = 600

onready var wallDetector = $WallDetector
onready var camera = $Camera2D
onready var animationPlayer = $AnimationPlayer
onready var dashCounterZone = get_parent().get_node("DashCounterZone")
onready var stats = LevelStats

enum {
	RIGHT,
	LEFT,
	UP,
	DOWN,
	NONE
}

var cameraLimits = [-5, -5, 365, 185]

var direction = NONE
var last_direction = NONE

var input_vector := Vector2.ZERO
var velocity := Vector2.ZERO
var moving := false
var cornerExploit := false

func _physics_process(delta):
	
	action_pressed()
	
	match direction:
		DOWN:
			move(0, SPEED)
			last_direction = DOWN
		UP:
			move(0, -SPEED)
			last_direction = UP
		LEFT:
			move(-SPEED, 0)
			last_direction = LEFT
		RIGHT:
			move(SPEED, 0)
			last_direction = RIGHT
		NONE:
			move(0, 0)
			camera.limit_right = 360
			camera.limit_bottom = 180
			camera.limit_left = 0
			camera.limit_top = 0
			animationPlayer.play("Idle")
	
#Define os valores de velocity		
func move(x : int, y : int):
	
	velocity.x = x
	velocity.y = y
	
	move_and_slide(velocity)

#Define qual tecla foi pressionada, o que deve acontecer se ela for pressionada
# e define a direção no qual ela será rotacionada
func action_pressed():
	
	if velocity == Vector2.ZERO:
		
		if Input.is_action_just_pressed("move_down") and last_direction != DOWN:
			
			wallDetector.set_deferred("monitoring", true)
			self.rotation_degrees = 180
			moving = true
			direction = DOWN
			
		if Input.is_action_just_pressed("move_left") and last_direction != LEFT:
			
			wallDetector.set_deferred("monitoring", true)
			self.rotation_degrees = 270
			moving = true
			direction = LEFT
			
		if Input.is_action_just_pressed("move_right") and last_direction != RIGHT:
			
			wallDetector.set_deferred("monitoring", true)	
			self.rotation_degrees = 90
			moving = true
			direction = RIGHT
			
		if Input.is_action_just_pressed("move_up") and last_direction != UP:
			
			wallDetector.set_deferred("monitoring", true)
			self.rotation_degrees = 0
			moving = true
			direction = UP
			
	if moving == false:
		direction = NONE
		
	if moving == true:
		camera.smoothing_enabled = true
		camera.limit_left = cameraLimits[0]
		camera.limit_top = cameraLimits[1]
		camera.limit_right = cameraLimits[2]
		camera.limit_bottom = cameraLimits[3]

#Detecta paredes, e desativa toda vez que encontra uma parede
func _on_WallDetector_body_entered(body):
	dashCounterZone.position = position
	self.rotation_degrees += 180
	moving = false
	dashCounterZone.set_deferred("monitoring", true)
	wallDetector.set_deferred("monitoring", false)

func _on_EnemyDetector_area_entered(area):
	queue_free()
	stats.died = true

func _on_DashCounterZone_body_exited(body):
	dashCounterZone.set_deferred("monitoring", false)
	stats.dashCount += 1
	animationPlayer.play("Dash")
