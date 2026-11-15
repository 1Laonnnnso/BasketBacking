extends RigidBody2D

var range = 5
var direction = Vector2.from_angle(0)  
var speed = 10.0                      
var velocity = direction * speed

func mains:


# Called when the node enters the scene tree for the first time.
'func passin(npass:bool, al:float) -> void: 
	if  npass == true:
		speed = state.linear_velocity(10)
		direction = Vector2.from_angle(al)
		for i in 10:
			speed = speed - speed*0.1
		 	if speed <= 1:
				i -= 5
				speed = state.linear_velocity(0)
				pass
				
	else:
		
		pass'
	 
func standy(x: float, y:float, rechts:bool) -> void:
	pos  = state.position(x-10,y)
	speed = state.linear_velocity(5)
	while y >= y-10:
		
		direction = Vector2.from_angle(-90)
	while y <= y+10:
		speed = state.linear_velocity(-5)
	
	
	pass
