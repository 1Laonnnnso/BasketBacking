extends CharacterBody2D

@export var speed : float = 5000.0
@export var jump_buffer : float = 0.1
@export var jump_velocity : float = -200.0

@export var gravity: float = 9.81

@export var held_ball : RigidBody2D = null
@export var throwSpeed : float
@export var push_force: float = 80.0
#@export var ball: RigidBody2D

var animatedSprite : AnimatedSprite2D
var lookDirection : Vector2 = Vector2.RIGHT
var pickupArea: Area2D


var holdPosition: Marker2D
var isHoldingBall : bool = false

func _ready() -> void:
	holdPosition = %ballPossition
	animatedSprite = %AnimatedSprite2D
	pickupArea = %pickupArea

var jump_buffer_timer : float = 0.0
var canJump = true
func _physics_process(delta) -> void:
	var dir = Input.get_axis("move_left", "move_right")
	
	if isHoldingBall and held_ball:
		held_ball.global_position = holdPosition.global_position
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer
	else:
		jump_buffer_timer = max(jump_buffer_timer - delta, 0.0)
		canJump = true
		
	
	if is_on_floor() && jump_buffer_timer > 0.0 && canJump:
		jump()
		jump_buffer_timer = 0.1
	
	
	velocity.x = dir * speed * delta
	
	move_and_slide()
	
	animation()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			collider.apply_central_impulse(-collision.get_normal() * push_force)
	

func jump():
	velocity.y = jump_velocity
	canJump = false
	

func animation():
	if velocity.x > 0:
		animatedSprite.play("walk")
		animatedSprite.flip_h = false
		lookDirection = Vector2.RIGHT
	elif velocity.x < 0:
		animatedSprite.play("walk")
		animatedSprite.flip_h = true
		lookDirection = Vector2.LEFT
	else:
		animatedSprite.play("idle")

func try_pickup_ball():
	
	if held_ball and pickupArea.overlaps_body(held_ball):
		held_ball.pickup(self)
		
		

func throw():
	if held_ball:
		held_ball.throw(lookDirection, throwSpeed)
		held_ball = null


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.name == "pickUpBall":
		try_pickup_ball()
		
