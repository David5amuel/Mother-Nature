extends StaticBody2D

export var plantSize := 0
export var is_harmful : bool

var the_position = 0
var growOne = 0
var growSize = 16
var stats = LevelStats

var trunk = preload("res://Scenes/World/RoseTrunk.tscn")
onready var animationPlayer = $AnimationPlayer
onready var collisionShape = $CollisionShape2D
onready var playerKiller = $PlayerKiller
onready var plantTopPart = $PlantTopPart
onready var sprite = $PlantTopPart/Sprite

func _ready():
	stats.connect("dashCountIncreased", self, "growUp")
	
func _physics_process(delta):

	friendlyOrHarmful()	

#Define se a planta vai matar o player ou servir de plataforma.
func friendlyOrHarmful():
	if is_harmful:
		set_collision_layer(3)
		playerKiller.set_deferred("monitorable", true)	
		collisionShape.set_deferred("disabled", true)
	else:
		set_collision_layer(1)
		playerKiller.set_deferred("monitorable", false)
		collisionShape.set_deferred("disabled", false)
	
#Faz a planta crescer com base no número de dashs dado pelo player
func growUp():
	
	if growOne < plantSize:
		plantTopPart.position.y -= growSize
		playerKiller.scale.y += 1
		playerKiller.position.y -= 8
		collisionShape.scale.y += 1
		collisionShape.position.y -= 8
		growOne += 1
		var world = get_tree().current_scene
		var new_trunk = trunk.instance()
		new_trunk.global_position = global_position - Vector2(0, the_position)
		world.add_child(new_trunk)
		the_position += 16
