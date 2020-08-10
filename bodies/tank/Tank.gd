extends KinematicBody2D

export (PackedScene) var Ball
export var group =  ""
onready var Spawner = $Spawner
onready var Anim = $AnimationPlayer
onready var Spr = $Sprite
onready var AudioMove = $Move
onready var AudioExplosion = $Explosion
var mov = Vector2.ZERO
const SPEED = 300
const ROT_SPEED = PI
var rot = 0
var collided = false

func _ready():
	add_to_group(group)
	Spr.frame = int(group) - 1

func _physics_process(delta):
	if not collided:
		mov = move_and_slide(mov)
		rotation = rot
		if Input.is_action_pressed("right_" + group):
			rot += ROT_SPEED * delta
		elif Input.is_action_pressed("left_" + group):
			rot -= ROT_SPEED * delta
		if Input.is_action_pressed("up_" + group):
			mov = Vector2(cos(rot), sin(rot)) * SPEED
		elif Input.is_action_pressed("down_" + group):
			mov = Vector2(cos(rot), sin(rot)) * -SPEED
		else:
			mov = Vector2.ZERO
		
		if mov.x != 0 or mov.y != 0:
			if not AudioMove.is_playing():
				AudioMove.play()
		else:
			AudioMove.stop()
		
		if Input.is_action_just_pressed("shoot_" + group):
			var new_ball = Ball.instance()
			new_ball.rot = rot
			new_ball.position = Spawner.global_position
			new_ball.player = group
			get_parent().add_child(new_ball)

func hit(p):
	if not collided:
		collided = true
		AudioMove.stop()
		Anim.play("dead")
		AudioExplosion.play()
		yield(Anim, "animation_finished")
		get_tree().current_scene.get_node("HUD").add_score(p)
		Global.level += 1
		Transition.change_level(Global.level)
