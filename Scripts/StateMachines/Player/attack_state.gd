extends State
class_name PlayerAttack
@onready var player_sprite: AnimatedSprite2D = $"../../PlayerSprite"
@onready var attack_area: Area2D = $"../../AttackArea"
@onready var attack_collidor: CollisionShape2D = $"../../AttackArea/AttackCollidor"
@onready var camera: Camera2D = $"../../Camera"
@onready var WeaponAnim: AnimatedSprite2D = $"../../AttackArea/Weapon"
@onready var player: CharacterBody2D = $"../.."
@onready var Bullet = load("res://Scenes/Objects/bullet.tscn")
# Combat Combo Stuff
@export var Combo_SetTime : float = 3.0

var holding : bool = false 

var RootParent 

func _ready() -> void:
	RootParent = player.get_parent()

@export var Weapon: WeaponStats 

var Damage : int = 0
var Left_PLayed := true
var Combo_Counter : int = 0
var Combo_timer : float 

@export var Shake_Intensity : float = 5
@export var Shake_Fade : float = 5

func Enter():
	
		attack_collidor.shape = Weapon.Shape
		Damage = Weapon.Damage
		
		if Weapon.Meelee:
			if Left_PLayed == true:
				WeaponAnim.play(Weapon.MeeleeRight)
				Left_PLayed = false
				
			else:
				WeaponAnim.play(Weapon.MeeleeLeft)
				Left_PLayed = true
				
			attack_collidor.disabled = false
			await WeaponAnim.animation_finished
			attack_collidor.disabled = true
				
		else:
			var instance = Bullet.instantiate()
			instance.speed = Weapon.BulletSpeed
			instance.life = Weapon.BulletLife
			
			instance.setup(attack_area.global_transform)
			get_tree().root.add_child(instance)
			
			pass
		
		
		
		
		#if Combo_Counter == 4:
			#WeaponAnim.play("Push")
			#Damage += 3
			#Combo_Counter = 0
		#else:
			#if Left_PLayed == true:
				#WeaponAnim.play(Weapon.animation1)
				#Left_PLayed = false
				#
			#else:
				#WeaponAnim.play(Weapon.animation2)
				#Left_PLayed = true
				#
			#
		#attack_collidor.disabled = false
		#await WeaponAnim.animation_finished
		#attack_collidor.disabled = true
		
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
		
	if Input.is_action_pressed("Attack"):
		holding = true
