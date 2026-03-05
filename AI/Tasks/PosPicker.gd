extends BTAction

@export var MinDist : float = -20.0
@export var MaxDist : float = 20.0

@export var RanDir : Vector2

@export var ChosenSpot : StringName = &"pos" 
@export var ChosenDir : StringName = &"dir"

func _tick(_delta: float) -> Status:
	var dir : Vector2 = RandomDir()
	var pos : Vector2 = RandomPos(dir)
	
	blackboard.set_var(ChosenSpot, pos)
	RandomDir()
	return SUCCESS


func RandomPos(dir):
	var position : Vector2
	var distance = Vector2(randf_range(MinDist,MaxDist),randf_range(MinDist,MaxDist))
	var finaldist = (distance + agent.global_position)
	position = finaldist
	return position
	
	

func RandomDir():
	var Dir = Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	).normalized()
	blackboard.set_var(ChosenDir, Dir)
	#print(Dir)
	return Dir
