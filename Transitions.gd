extends CanvasLayer

signal transition_completed

func play_death_transition():
	$AnimationPlayer.play("DeathTransition")

func play_enter_transition():
	$AnimationPlayer.play("Enter Level Transition")
	
func play_warp_transition():
	$AnimationPlayer.play("Warp")
	
func play_win_transition():
	$AnimationPlayer.play("WinTransition")
	
func play_win_transition2():
	$AnimationPlayer.play("WinTransition2")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("transition_completed")
