extends Area2D

var velocity = Vector2(0,0)

func _physics_process(delta):
	position+=velocity*delta
