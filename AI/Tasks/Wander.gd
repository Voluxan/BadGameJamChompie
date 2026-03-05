extends BTAction

@export var TargetPos := &"pos"
@export var TargetDir := &"dir"

@export var WanderTime : float = 1.2
var WanderTimer : float = -1.0
func _enter() -> void:
	WanderTimer = WanderTime

func _tick(_delta: float) -> Status:
	timers(_delta)
	var Target: Vector2 = blackboard.get_var(TargetPos, Vector2.ZERO)
	var dir = blackboard.get_var(TargetDir)
	if WanderTimer <= 0.0:
		#print("TimeOut")
		agent.Wander(Vector2.ZERO)
		return SUCCESS
	else:
		
		agent.Wander(dir)
		return RUNNING

func timers(delta):
	if WanderTimer > 0.0:
		WanderTimer -= delta
	pass
