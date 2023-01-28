extends Area2D



func _process(delta):
	$AnimatedSprite.animation = "Idle"
	
func _on_Coin_body_entered(body):
	if body.has_method("GetCoin"):
		body.GetCoin()
		queue_free()

