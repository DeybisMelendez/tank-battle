extends Area2D

onready var ColorR = $ColorRect
onready var Hit = $Hit
var dir = Vector2.ZERO
var rot = 0
var player = ""
var collided = false
const SPEED = 500
const ROT_SPEED = TAU


func _ready():
	connect("body_entered", self, "body_entered")
	if player == "2":
		ColorR.color = Color("29ADFF")

func _physics_process(delta):
	if not collided:
		dir = Vector2(cos(rot), sin(rot))
		global_position += dir * SPEED * delta
		if Input.is_action_pressed("right_" + player):
			rot += ROT_SPEED * delta
		elif Input.is_action_pressed("left_" + player):
			rot -= ROT_SPEED * delta

func body_entered(body):
	if not collided:
		if body.is_in_group("tank"):
			body.hit(player)
			queue_free()
		elif not body.is_in_group(player):
			Hit.play()
			hide()
			yield(Hit,"finished")
			queue_free()
		collided = true
