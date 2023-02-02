extends StaticBody2D

export var plantSize := 0
export var is_harmful : bool

var growOne = 0
var stats = LevelStats

onready var collisionShape = $CollisionShape2D
onready var playerKiller = $PlayerKiller
onready var sprite = $Sprite

func _ready():
	stats.connect("dashCountIncreased", self, "growUp")
	
func _physics_process(delta):
	print(playerKiller.monitoring)
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
		sprite.scale.y += 1
		sprite.position.y -= 8
		playerKiller.scale.y += 1
		playerKiller.position.y -= 8
		collisionShape.scale.y += 1
		collisionShape.position.y -= 8
		growOne += 1
