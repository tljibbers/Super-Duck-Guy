extends Area2D

var velocity: Vector2 = Vector2()
var duration = 5

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	position += velocity * delta
	
	duration -= delta
	if duration <= 0:
		queue_free()
		
func _on_body_entered(body):
	
	if body is Player:
		body.player_die()
