extends State
class_name PlayerIdle
#@onready var Char: AnimatedSprite2D = $"../../char"

func Enter():
	#Char.play("Idle")
	pass
	
#func Exit():
	#pass
	
func Update(_delta:float):
	if(Input.get_vector("Left", "Right", "Up", "Down").normalized()):
		state_transition.emit(self, "Moving")
		
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "Attacking")
	
