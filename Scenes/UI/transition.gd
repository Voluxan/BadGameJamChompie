extends CanvasLayer
@onready var animation_player: AnimationPlayer = $TransitionScreen/AnimationPlayer

func transition(transition: String) -> void:
	if (transition == "FadeIn"):
		animation_player.play("fade_in")
	elif (transition == "FadeOut"):
		animation_player.play("fade_out")
		await animation_player.animation_finished
		animation_player.play("RESET")
	pass
