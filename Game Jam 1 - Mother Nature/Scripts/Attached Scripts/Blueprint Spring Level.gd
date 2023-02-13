extends Node2D

onready var player = $Player
var myself = self
var stats = LevelStats

func _ready():
	$RestartButton.visible = false

func _process(delta):
	if stats.died == true:
		$RestartButton.visible = true

func _on_RestartButton_button_up():
	stats.sunCount *= 0
	stats.died = false
	get_tree().reload_current_scene()	
