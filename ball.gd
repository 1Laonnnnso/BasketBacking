extends RigidBody2D

var isHeld: bool = false
var thrower: Node2D = null

func pick_up(player: Node2D):
	isHeld = true
	thrower = player
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0

func throw(throwDirection: Vector2, throwSpeed: float):
	isHeld = false
	thrower = null
	freeze = false # Unfreeze the rigid body so physics take over again
	apply_central_impulse(throwDirection * throwSpeed)
