extends CharacterBody2D
 
@export var Humanoid: Humanoids 
var HealthPoints : int 

var push_dir: Vector2 = Vector2(0, 0)
var push_strength: float = 0.0
var push_timer: float = 0.0

func _physics_process(delta: float) -> void:
	#if Humanoid.KnockbackTimer > 0.0:
		#velocity 
		#Humanoid.KnockbackTimer -= delta
		#if Humanoid.KnockbackTimer <= 0.0:
			#Humanoid.Knockback = Vector2.ZERO
			#
	#velocity = Humanoid.Knockback
	#move_and_slide()
	push_back(delta)

func _ready() -> void:
	HealthPoints = Humanoid.MaxHealth

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
