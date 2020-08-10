extends CanvasLayer

onready var P1 = $HBoxContainer/P1
onready var P2 = $HBoxContainer/P2

func add_score(player):
	if player == "1":
		Global.score_1 += 1
	else:
		Global.score_2 += 1

func _ready():
	update_score()

func update_score():
	P1.text = str(Global.score_1)
	P2.text = str(Global.score_2)
