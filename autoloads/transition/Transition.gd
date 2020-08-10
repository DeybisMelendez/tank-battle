extends CanvasLayer

onready var Anim = $AnimationPlayer
const LEVEL_PATH = "res://scenes/levels/"
func change_scene(scene):
	#get_tree().paused = true
	Anim.play("fade_in")
	yield(Anim, "animation_finished")
	get_tree().change_scene(scene)
	Anim.play("fade_out")
	#get_tree().paused = false

func change_level(level):
	change_scene(LEVEL_PATH + str(level) + ".tscn")
