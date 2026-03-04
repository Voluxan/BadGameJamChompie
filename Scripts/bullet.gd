extends Area2D

@export var speed: float = 80.0
@export var damage: int = 30
@export var life: float
@export var Knockback: int
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(life)

func _physics_process(delta):
	position += transform.x * speed * delta

func setup(trans: Transform2D):
	transform = trans



func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(body: Area2D) -> void:
	if body.has_method("TakeDamage"):
		body.TakeDamage(damage, transform, Knockback)
	queue_free()
	pass # Replace with function body.
