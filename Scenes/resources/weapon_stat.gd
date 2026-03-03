extends Resource
class_name WeaponStats

# -- Base
@export var texture: Texture2D
@export var Shape: Shape2D

# -- Damage & Type
@export var Damage: int
@export var Crit: int

@export var DamageType: String

@export var Meelee: bool
@export var holdable: bool
@export var AttackCooldown: float
# -- Bullet Stuff
@export var BulletLife: float
@export var BulletSpeed: float
@export var BulletAmount: int

# -- Animation Stuff
@export var MeeleeLeft: String
@export var MeeleeRight: String
@export var MeeleeExtra: String
@export var animation3: String
