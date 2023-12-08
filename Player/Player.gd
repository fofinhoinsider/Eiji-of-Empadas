extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped_on_air = false

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	var suffix = "BC" if Game.Gold >= 4 else ""

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_jumped_on_air = false
	# Handle Jump.
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("Jump" + suffix)
		elif not has_jumped_on_air and Game.Gold >= 4:
			velocity.y = JUMP_VELOCITY			
			anim.play("Jump" + suffix)
			has_jumped_on_air = 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run" + suffix)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle" + suffix)
	if velocity.y > 0:
		anim.play("Fall" + suffix)	
	move_and_slide()
	
	
	if Game.playerHP <= 0 or position.y > 2000:
		queue_free()
		Game.playerHP = 3
		Game.Gold = 0
		get_tree().change_scene_to_file("res://menu.tscn")
