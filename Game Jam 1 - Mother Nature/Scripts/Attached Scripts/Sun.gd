extends Area2D

var stats = LevelStats

func _ready():
	stats.sunCount += 1

func _on_Sun_body_entered(body):
	stats.sunCount -= 1
	queue_free()
