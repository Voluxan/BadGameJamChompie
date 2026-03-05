extends CanvasLayer
@onready var animation_player: AnimationPlayer = $TransitionScreen/AnimationPlayer

func transition(trans: String) -> void:
	if (trans == "FadeIn"):
		animation_player.play("fade_in")
	elif (trans == "FadeOut"):
		animation_player.play("fade_out")
		await animation_player.animation_finished
		animation_player.play("RESET")
	pass
