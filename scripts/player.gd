extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var gravity = 400
@export var speed = 120
@export var jump_force = 200

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	
	
	var direction = Input.get_axis("move_left", "move_right")	
	velocity.x = direction * speed	
	move_and_slide()







#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
