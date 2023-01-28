extends Node2D

var destination

func _ready():
	destination = get_node("WarpDestination").get_global_position()


func _on_Area2D_body_entered(body):
	if body is Player:
		body.warp()
		body.set_position(destination)
