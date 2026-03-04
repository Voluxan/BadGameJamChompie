extends Camera2D

@export var RandomStrenght:float = 30.0
@export var shakeFade:float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength:float = 0.0

func apply_shake(Strenght, Fade):
	RandomStrenght = Strenght
	shakeFade = Fade
	
	shake_strength = RandomStrenght
	

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
