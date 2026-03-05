extends State
class_name PlayerDash

@onready var player: CharacterBody2D = $"../.."

@export var DashSpeed : float = 2500
@export var DashTime : float = 0.25
@export var DashReTime : float = 1
var canDash : bool = true
var dashTimer: float = 0.0
var dashReTimer : float = 0.0
var dashDir: Vector2 = Vector2.ZERO


func Update(_delta:float):
	if canDash :
		canDash = false
		dashTimer = DashTime
		dashReTimer = DashReTime
		
		dashDir = player.global_position.direction_to(player.get_global_mouse_position())
		player.velocity = dashDir * DashSpeed
		
	state_transition.emit(self, "Idle")
	
	


func _process(delta: float) -> void:
	if dashTimer > 0.0:
		dashTimer = max(0.0, dashTimer - delta)
	else:
		if dashReTimer > 0.0:
			dashReTimer -= delta
		else:
			canDash = true
			
		pass
