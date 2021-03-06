extends KinematicBody2D

const MAX_SPEED = 20
const FRICTION = 1000
const ACCELERATION = 10
var velocity = Vector2.ZERO
var health = 2500
var min_dist_to_player = 100
var player = null

onready var weapon = get_node("Weapon")
onready var animationPlayer = get_node("TwoFront/AnimationPlayer")

func _ready():
	weapon.update_pos_parent(
		Vector2(100, 10),
		Vector2(-100, 10),
		Vector2(100, 10),
		Vector2(-100, 10)
	)

func _process(delta):
		
	if health <= 0:
		queue_free()

func _physics_process(delta):

	if player != null:
		
		if weapon != null:
			weapon.shoot(delta)
	
		var input_vector : Vector2 = player.position - position
		
		if input_vector.length() <= min_dist_to_player:
			input_vector = Vector2.ZERO
		else:
			input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			
			if(input_vector.y < 0):
				animationPlayer = get_node("TwoBack/AnimationPlayer")
				animationPlayer.play("BackVertical")
				
				get_node("TwoRight").hide()
				get_node("TwoFront").hide()
				get_node("TwoLeft").hide()
				get_node("TwoBack").show()
				
			elif(input_vector.y > 0):
				animationPlayer = get_node("TwoFront/AnimationPlayer")
				animationPlayer.play("FrontVertical")
				
				get_node("TwoRight").hide()
				get_node("TwoLeft").hide()
				get_node("TwoBack").hide()
				get_node("TwoFront").show()
				
			elif(input_vector.x > 0):
				animationPlayer = get_node("TwoRight/AnimationPlayer")
				animationPlayer.play("RightHorizontal")
				
				get_node("TwoFront").hide()
				get_node("TwoLeft").hide()
				get_node("TwoBack").hide()
				get_node("TwoRight").show()
				
			elif(input_vector.x < 0):
				animationPlayer = get_node("TwoLeft/AnimationPlayer")
				animationPlayer.play("LeftHorizontal")
				
				get_node("TwoRight").hide()
				get_node("TwoFront").hide()
				get_node("TwoBack").hide()
				get_node("TwoLeft").show()
				
			velocity += input_vector * ACCELERATION
			velocity = velocity.clamped(MAX_SPEED)
			
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationPlayer.play("Idle")
			
		velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	
	if body.name == 'Player':
		player = body
