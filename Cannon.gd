extends StaticBody2D

const bullet = preload("res://Bullet.tscn")

func shoot(direction, speed):
	var new_bullet = bullet.instance()
	new_bullet.velocity = Vector2(speed, 0).rotated(deg2rad(direction))
	new_bullet.position = position
	get_parent().add_child(new_bullet)
