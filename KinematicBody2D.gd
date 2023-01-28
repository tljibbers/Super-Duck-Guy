extends KinematicBody2D
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var ledgeCheckRight: = $LedgeCheckRight
onready var ledgeCheckLeft: = $LedgeCheckLeft

func _physics_process(delta):
	$AnimatedSprite.play("Run")
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheckRight.is_colliding() or not ledgeCheckLeft.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1
		
	$AnimatedSprite.flip_h = direction.x > 0
	
	var snap = Vector2.DOWN * 10
	velocity = direction * 25
	move_and_slide_with_snap(velocity, snap, Vector2.UP)




func _on_sides_checker_body_entered(body):
	if body is Player:
		body.player_die()

func _on_top_checker_body_entered(body):
	if body is Player:
		$Hit.play()
		body.bounce()
		queue_free()
