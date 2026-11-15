extends CharacterBody2D

@export var speed: float = 30.0
@export var gravity: float = 9.81

var player: Node2D = null

func _ready() -> void:

	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if player:
		var direction = sign(player.global_position.x - global_position.x)
		velocity.x = direction * speed
		
		
		if direction > 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
		elif direction < 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = 0

	move_and_slide()


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Ball" or body.is_in_group("ball"):
		queue_free()
