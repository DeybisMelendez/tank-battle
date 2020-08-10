extends Control

onready var Play = $VBoxContainer/Play

func _ready():
	Play.connect("button_up", self, "play")

func play():
	Transition.change_scene("res://scenes/levels/1.tscn")
