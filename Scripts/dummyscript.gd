extends CharacterBody2D
 
@export var Humanoid: Humanoids 
var HealthPoints : int 
var StartPos : Vector2
@onready var brain: NavigationAgent2D = $Brain

var push_dir: Vector2 = Vector2(0, 0)
var push_strength: float = 0.0
var push_timer: float = 0.0
var TargetDir = Vector2.ZERO

@export var accel : float = 5
@export var friction : float = 8
func _physics_process(delta: float) -> void:
	
	var lerp_weight = delta * (accel if TargetDir else friction)
	velocity = lerp(velocity, TargetDir * Humanoid.Speed, lerp_weight)
	
	push_back(delta)
	move_and_slide()


func _ready() -> void:
	HealthPoints = Humanoid.MaxHealth
	StartPos = global_position

func healthFunc(Amount):
	HealthPoints += Amount
	
func set_push(dir: Vector2, strength: float, timer: float):
	push_dir = -dir
	push_strength = strength
	push_timer = timer

func push_back(delta: float):
	if push_timer > 0.0:
		position -= push_dir * push_strength * delta
		push_timer -= delta
	else:
		push_timer = 0.0

func GetHit(Amount, Trans, Power):
	set_push(Vector2.RIGHT.rotated(Trans.get_rotation()), Power, 0.1)
	healthFunc(Amount)


func Wander(WanderDir):
	TargetDir = WanderDir
	
