extends CharacterBody2D

const SPEED = 50.0

var movement = "Idle"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var moveCount = 0
var valid = true

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	velocity.y += gravity * delta
	
	match movement:
		"Idle":
			anim.play("Idle")
			await anim.animation_finished
			velocity.x = 0
		"MoveRight":
			velocity.x = SPEED
			anim.play("Idle")
			moveCount += 1
			if moveCount > 100:
				moveCount = 0
				movement = "OpenEye"
		"OpenEye":
			velocity.x = 0
			anim.play("OpenEye")
			await anim.animation_finished
			movement = "MoveLeft"
		"MoveLeft":
			velocity.x = -1 * SPEED
			anim.play("EyeOpen")
			moveCount += 1
			if moveCount > 100:
				moveCount = 0
				movement = "CloseEye"
		"CloseEye":
			velocity.x = 0
			anim.play("CloseEye")
			await anim.animation_finished
			movement = "MoveRight"
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		movement = "MoveRight"


func _on_player_death_body_entered(body):
	if body.name == "Player":
		if movement != "MoveLeft":
			Game.playerHP -= 1
		else:
			self.queue_free()
