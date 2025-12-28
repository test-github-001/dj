extends CharacterBody2D

# --- Константы ---
const SPEED = 200.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1000.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var last_dir = 1  # 1 = вправо, -1 = влево
	
func _physics_process(delta):
	# --- Физика ---
	#if not is_on_floor():
	#	velocity.y += GRAVITY * delta
		
	# --- Движение ---
	var input_dir = 0.0
	if Input.is_action_pressed("Left"):
		input_dir -= 1
	if Input.is_action_pressed("Right"):
		input_dir += 1
	velocity.x = input_dir * SPEED

	# --- Направление ---
	if velocity.x > 0:
		last_dir = 1
	elif velocity.x < 0:
		last_dir = -1
		
	# --- Анимация ---
	if is_on_floor():
		# На земле всегда jump
		if Input.is_action_pressed("Shoot"):
			anim.play("shoot_jump")
		elif last_dir > 0:
			anim.play("right_jump")
		else:
			anim.play("left_jump")
	else:
		# В воздухе базовые
		if Input.is_action_pressed("Shoot"):
			anim.play("shoot")
		elif last_dir > 0:
			anim.play("right")
		else:
			anim.play("left")

	move_and_slide()
