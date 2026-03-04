extends Resource
class_name Humanoids


# -- | Player Stuff
@export var IsPlayer : bool = false

# -- | Health & Stuff 
@export var MaxHealth : int = 100
@export var Healing : bool = false
@export var shield : int = 0
@export var stamina : int = 50

# -- | Extra stuffs
@export var Knockback : Vector2 = Vector2.ZERO
@export var KnockbackTimer : float = 0.0
