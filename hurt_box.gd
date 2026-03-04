extends Area2D



func _on_area_entered(_area: Area2D) -> void:
	
	pass # Replace with function body.

func TakeDamage(damage, trans, Knockback):
	print(str(damage) + " damage")
	get_parent().GetHit(damage, trans, Knockback)
	
	get_viewport().get_camera_2d().apply_shake(1.5,5)
	
