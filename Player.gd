extends KinematicBody2D
class_name Player

export(int) var JUMP_FORCE = -130
export(int) var JUMP_RELEASE_FORCE = -70
export(int) var MAX_SPEED = 50
export(int) var SPRINT_SPEED = MAX_SPEED * 3
export(int) var ACCELERATION = 10
export(int) var FRICTION = 10
export(int) var GRAVITY = 4
export(int) var ADDITIONAL_FALL_GRAVITY = 4
var velocity = Vector2.ZERO
var coins = 0



func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.speed_scale = 1
	else:
		if Input.is_action_pressed("ui_sprint"):
			apply_acceleration_sprint(input.x)
			$AnimatedSprite.animation = "Run"
			$AnimatedSprite.speed_scale = 3
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
			apply_acceleration(input.x)
			$AnimatedSprite.animation = "Run"
			$AnimatedSprite.speed_scale = 1
		if input.x > 0:
			$AnimatedSprite.flip_h = false
		elif input.x < 0:
			$AnimatedSprite.flip_h = true
			
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
			$Jump.play()
	else:
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		
		if velocity.y > 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY
			
	
	var snap = Vector2.DOWN * 10 if !Input.is_action_pressed("ui_up") else Vector2.ZERO
	
	var was_in_air = not is_on_floor()		
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1
		
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.animation = "Warp"
		
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
		
func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 300)
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)
	
func apply_acceleration_sprint(amount):
	velocity.x = move_toward(velocity.x, SPRINT_SPEED * amount, ACCELERATION)
	
func player_die():
	$Death.play()
	Transitions.play_death_transition()
	get_tree().paused = true
	yield(Transitions, "transition_completed")
	Transitions.play_enter_transition()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func bounce():
	velocity.y = JUMP_FORCE * 0.7
	
func warp():
	Transitions.play_warp_transition()
	get_tree().paused = true
	yield(Transitions, "transition_completed")
	Transitions.play_enter_transition()
	get_tree().paused = false
	
func GetCoin():
	coins += 1
	$Coin.play()
	
func winGame():
	$Win.play()
	Transitions.play_win_transition()
	get_tree().paused = true
	yield(Transitions, "transition_completed")
	Transitions.play_win_transition2()
	get_tree().paused = false
	get_tree().change_scene("res://Start.tscn")
	$Win.play()
	
