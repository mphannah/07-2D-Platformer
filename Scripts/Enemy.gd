extends KinematicBody2D

const SPEED = 30

onready var data = get_node("/root/PlayerData")

export var score: = 10
var _direction = -1


func _physics_process(delta: float) -> void:
	var _velocity = Vector2(SPEED, 0.0) * _direction
	move_and_slide(_velocity)
	if is_on_wall():
		_direction = _direction * -1
		$RayCast2D.position.x *= -1
		if _direction == 1:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
	if $RayCast2D.is_colliding() == false:
		_direction = _direction * -1
		$RayCast2D.position.x *= -1
		if _direction == 1:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false

func _on_Area2D_area_entered(area):
	die()

func die():
	queue_free()
	data.set_score(score)
	

