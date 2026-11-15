extends RigidBody2D

var isHeld: bool = false
var thrower: Node2D = null

func _physics_process(delta: float) -> void:
	# Wenn der Ball gehalten wird und ein Spieler zugewiesen ist
	if isHeld and thrower:
		# Holt die Position des Marker2D vom Spieler (anhand des Node-Namens "%ballPossition")
		if thrower.has_node("ballPossition"):
			global_position = thrower.get_node("ballPossition").global_position
		elif thrower.has_node("%ballPossition"):
			global_position = thrower.get_node("%ballPossition").global_position

	# Rotation des Area2D ausgleichen
	$Area2D/CollisionShape2D.rotation = -rotation

func pick_up(player: Node2D):
	isHeld = true
	thrower = player
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0

func throw(throwDirection: Vector2, throwSpeed: float):
	isHeld = false
	thrower = null
	freeze = false # Physik wieder aktivieren
	apply_central_impulse(throwDirection * throwSpeed)

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		# Falls der Spieler den Ball berührt und noch keinen hält
		if not isHeld and body.has_method("try_pickup_ball") and not body.isHoldingBall:
			body.held_ball = self
			body.isHoldingBall = true
			body.try_pickup_ball()
