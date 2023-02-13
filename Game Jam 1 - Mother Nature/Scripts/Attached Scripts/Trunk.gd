extends Sprite

onready var stats = LevelStats

var frames = [60, 61, 62]

func _ready():
	if stats.dashCount != 0:
		self.frame = frames[stats.frameCount]	
