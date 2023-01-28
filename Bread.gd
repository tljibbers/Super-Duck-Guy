extends Area2D






func _on_Bread_body_entered(body):
	if body is Player:
		body.winGame()
