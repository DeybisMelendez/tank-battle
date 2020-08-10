extends Control

onready var Player = $VBoxContainer/Player
onready var Restart = $VBoxContainer/HBoxContainer/Restart
func _ready():
	Restart.connect("button_up", self, "restart")
	if Global.score_2 > Global.score_1:
		Player.text = "Player 2"

func restart():
	Global.level = 1
	Global.score_1 = 0
	Global.score_2 = 0
	Transition.change_scene("res://scenes/levels/1.tscn")
