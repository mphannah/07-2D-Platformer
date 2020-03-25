extends KinematicBody2D

const UP = Vector2(0, -1)
const ACCELERATION = 25
const GRAVITY = 10
const MAX_SPEED = 200
const JUMP = -300
const CRAWL_SPEED = 100

onready var standard_collision = $StandardShape
onready var crouching_collision = $CrouchingShape
onready var punch = $Sprite/Area2D/Punch
onready var background = $ParallaxBackground/ParallaxLayer/background1
onready var data = get_node("/root/PlayerData")

export(String, FILE) var next_world = ""

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
	
	if Input.is_action_pressed("space"):
		punch.disabled = false
	if Input.is_action_just_released("space"):
		punch.disabled = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		if Input.is_action_pressed("ui_down"):
			_on_crouch()
			if Input.is_action_pressed("ui_right"):
				motion.x = min(motion.x + ACCELERATION, CRAWL_SPEED)
			if Input.is_action_pressed("ui_left"):
				motion.x = max(motion.x - ACCELERATION, -CRAWL_SPEED)
		_on_stand()
	else:
		if motion.y < 0:
			if Input.is_action_just_released("ui_up"):
				motion.y += 125
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		if position.y >= 550:
			die()
	
	motion = move_and_slide(motion, UP)


func _process(delta): 
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
	
	if is_on_floor():
		if Input.is_action_pressed("ui_down"):
			$Sprite.play("Crouch")
			if Input.is_action_pressed("ui_right"):
				$Sprite.flip_h = false
				$Sprite.play("Crawl")
			if Input.is_action_pressed("ui_left"):
				$Sprite.flip_h = true
				$Sprite.play("Crawl")
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
	
	if Input.is_action_pressed("space"):
		$Sprite.play("Punch")
	if Input.is_action_just_released("space"):
		$Sprite.stop()

func _on_crouch():
	standard_collision.disabled = true
	crouching_collision.disabled = false

func _on_stand():
	standard_collision.disabled = false
	crouching_collision.disabled = true

func _on_EnemyDetector_body_entered(body):
	die()

func die():
	data.set_lives(-1)
	queue_free()
	if data.lives != 0:
		get_tree().change_scene(next_world)
	elif data.lives <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_SceneChange_area_entered(area):
	background.visible = false
