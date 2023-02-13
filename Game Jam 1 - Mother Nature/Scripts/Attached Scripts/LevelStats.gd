extends Node

onready var suns = LevelStats.sunCount

export(PackedScene) var nextScene

var dashCount := 0 setget set_dashCount
var sunCount := 0 setget set_sunCount
var frameCount := 0 setget set_frameCount
var died := false

signal dashCountIncreased
signal levelCompleted

func _process(delta):
	print(sunCount)
	if LevelStats.sunCount == 0:
		get_tree().change_scene_to(nextScene)

func set_dashCount(value):
	dashCount = value
	emit_signal("dashCountIncreased")
	if dashCount != 0:
		frameCount += 1
	if frameCount > 2:
		frameCount *= 0

func set_sunCount(value):
	sunCount = value
	if sunCount == 0:
		emit_signal("levelCompleted")
		
func set_frameCount(value):
	frameCount = value
