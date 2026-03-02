extends State
class_name PlayerAttack
@onready var player_sprite: AnimatedSprite2D = $"../../PlayerSprite"
@onready var fists: AnimatedSprite2D = $"../../PlayerSprite/Fists"
@onready var attack_collidor: CollisionShape2D = $"../../PlayerSprite/Fists/AttackArea/AttackCollidor"
@onready var camera: Camera2D = $"../../Camera"

# Combat Combo Stuff
@export var BaseDamage : int = 5
@export var Combo_SetTime : float = 3.0
var Damage : int = 5
var Left_PLayed := true
var Combo_Counter : int = 0
var Combo_timer : float 

@export var Shake_Intensity : float = 5
@export var Shake_Fade : float = 5



func Enter():
		Damage = BaseDamage
		if Combo_Counter == 4:
			fists.play("Push")
			Damage += 3
			Combo_Counter = 0
		else:
			if Left_PLayed == true:
				fists.play("PunchR")
				Left_PLayed = false
				
			else:
				fists.play("PunchL")
				Left_PLayed = true
				
			
		attack_collidor.disabled = false
		await fists.frame_changed
		attack_collidor.disabled = true
		

	
func Exit():
	pass
	
func Update(_delta:float):
	state_transition.emit(self, "Idle")
	


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("TakeDamage"):
		body.TakeDamage(Damage)
		camera.apply_shake(Shake_Intensity,Shake_Fade)
		Combo_Counter += 1
		Combo_timer = Combo_SetTime
	

func _physics_process(delta: float) -> void:
	#print(Combo_timer)
	if Combo_timer > 0:
		Combo_timer -= delta
	elif Combo_timer <= 0:
		Combo_Counter = 0
