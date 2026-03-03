extends Area2D
@onready var WeaponAnim: AnimatedSprite2D = $Weapon
@onready var attack_collidor: CollisionShape2D = $AttackCollidor
@onready var Bullet = load("res://Scenes/Objects/bullet.tscn")
@onready var camera: Camera2D = $"../Camera"

@export var Weapon: WeaponStats 

var Damage : int = 0
var Left_PLayed := true
var Combo_Counter : int = 0
var Combo_timer : float 

@export var Shake_Intensity : float = 5
@export var Shake_Fade : float = 5

var cooldown : float = 0
var timer : float = 5
var CanMeelee : bool = true

func _ready() -> void:
	timer = Weapon.AttackCooldown
	pass
	
func _physics_process(delta: float) -> void:
	Attack()
	timers(delta)

func Attack():
	if Input.is_action_pressed("Attack"):	
		
		
		if Weapon.Meelee:
			if CanMeelee == false : return
			CanMeelee = false
			if Left_PLayed == true:
				WeaponAnim.play(Weapon.MeeleeRight)
				Left_PLayed = false
				
			else:
				WeaponAnim.play(Weapon.MeeleeLeft)
				Left_PLayed = true
				
			attack_collidor.disabled = false
			await WeaponAnim.animation_finished
			attack_collidor.disabled = true
			CanMeelee = true

		else:
			if cooldown > 0 : return
			cooldown = timer

			var instance = Bullet.instantiate()
			instance.speed = Weapon.BulletSpeed
			instance.life = Weapon.BulletLife
			instance.damage = Weapon.Damage
			instance.setup(global_transform)
			get_tree().root.add_child(instance)

func timers(delta):
	if cooldown > 0:
		cooldown -= delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("TakeDamage"):
		body.TakeDamage(Damage)
		camera.apply_shake(Shake_Intensity,Shake_Fade)
		
	
	pass # Replace with function body.
