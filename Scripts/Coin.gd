extends Area2D

onready var data = get_node("/root/PlayerData")
var score = 1

func _on_Coin_body_entered(body):
	queue_free()
	picked()

func picked():
	data.set_score(score)
