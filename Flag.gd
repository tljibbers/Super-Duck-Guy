extends Area2D

func _ready():
	$Sprite.play("Idle")
	
func _on_Flag_body_entered(body):
	Checkpoint.last_position = global_position
	$Check.play()
	$Sprite.play("Checkpoint")
	
	
