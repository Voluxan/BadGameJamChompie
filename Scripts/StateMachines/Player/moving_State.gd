extends State
class_name PlayerMoving

@export var maxspeed : float = 80.0
@export var accel : float = 5
@export var friction : float = 8
#var player : CharacterBody2D
@onready var player: CharacterBody2D = $"../.."
var isrunning = false
# @onready var Char: AnimatedSprite2D = $"../../char"
#var face_direction := 1.0

func Enter(): # Replacement for _Ready
	isrunning = true
	
	#player = get_tree().get_first_node_in_group("Player")
	pass
	
func Update(_delta:float): # Replace ment for _process
	var input_dir : Vector2 = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
		).normalized()
	Move(input_dir, _delta)

func _physics_process(delta: float) -> void:
	if isrunning == false:	
		Move(Vector2.ZERO, delta)

	
func Move(input_dir : Vector2, delta):

	var lerp_weight = delta * (accel if input_dir else friction)
	player.velocity = lerp(player.velocity, input_dir * maxspeed, lerp_weight)

	#var VelocityWeightX : float = 1.0 - exp( -(accel if input_dir.x else friction) * delta)
	#player.velocity.x = lerp(player.velocity.x, input_dir.x * maxspeed, VelocityWeightX)
	#var VelocityWeightY : float = 1.0 - exp( -(accel if input_dir.y else friction) * delta)
	#player.velocity.y = lerp(player.velocity.y, input_dir.y * maxspeed, VelocityWeightY)
	
	#player.velocity = input_dir * maxspeed
	player.move_and_slide()
	
	#player.apply_scale(Vector2(input_dir.x * face_direction, 1)) # flip
	#face_direction = input_dir.x # remember direction
	#print(input_dir.x)
	#if(input_dir.x <= -0.1 ):
		#Char.flip_h = true
	#elif(input_dir.x >= 0.1):
		#Char.flip_h = false	

	if(input_dir.length() <= 0):
		isrunning = false
		Transition("Idle")
	else:
		pass
		
func Transition(newstate : String):
		state_transition.emit(self, newstate)
