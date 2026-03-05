extends Node2D
@onready var transition_screen: CanvasLayer = %TransitionScreen


@onready var Walls: CollisionPolygon2D = $Outer/Walls
var Battling : bool = false
var Player	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and (Battling == true):
		if Player:
			if Player.position.x > 350:
				_leave_arena(Player,"Right",Player.position)
				print("Right")
			elif Player.position.x < -350:
				_leave_arena(Player,"Left",Player.position)
				print("Left")
			elif Player.position.y > 300:
				_leave_arena(Player,"Down",Player.position)
				print("Down")
			elif Player.position.y < -300:
				_leave_arena(Player,"Up",Player.position)
				print("up")
			pass

func _near_exit_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and (Battling == true):
		print("Player Wants to leave")
		Player = body
		print(body.position)

func _left_exit_region(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player left/changed their mind")
		Player = TYPE_NIL
		
	pass # Replace with function body.


func _start_arena(body: Node2D) -> void:
	if body.is_in_group("Player") and (Battling == false):
		Battling = true
		Walls.set_deferred("disabled", false)
	pass # Replace with function body.

func _leave_arena(player, side, pos) -> void:
	transition_screen.transition("FadeIn")
	await transition_screen.animation_player.animation_finished
	match side:
		"Right":
			player.position = Vector2(pos.x + 60, pos.y )
		"Left":
			player.position = Vector2(pos.x - 60, pos.y )
		"Up":
			player.position = Vector2(pos.x , pos.y - 60)
		"Down":
			player.position = Vector2(pos.x , pos.y + 60)
	
	transition_screen.transition("FadeOut")
	Battling = false
	Walls.set_deferred("disabled", true)
