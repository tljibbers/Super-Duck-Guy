extends Node2D

func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position
	

func _ready():
	VisualServer.set_default_clear_color(Color.cornflower)


func _on_fallzone_body_entered(body):
	if body is Player:
		body.player_die()
		
