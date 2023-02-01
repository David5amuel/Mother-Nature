extends Node

onready var suns = LevelStats.sunCount

export(PackedScene) var nextScene

var dashCount := 0 setget set_dashCount
var sunCount := 0 setget set_sunCount

signal dashCountIncreased
signal levelCompleted

func _process(delta):
	if LevelStats.sunCount == 0:
		get_tree().change_scene_to(nextScene)

func set_dashCount(value):
	dashCount = value
	emit_signal("dashCountIncreased")

func set_sunCount(value):
	sunCount = value
	if sunCount == 0:
		emit_signal("levelCompleted")
