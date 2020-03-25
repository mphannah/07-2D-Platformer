extends Node


signal updated
signal died
signal reset

var score: = 0 setget set_score
var lives: = 5 setget set_lives

func reset():
	score = 0
	lives = 5
	emit_signal("reset")

func set_score(new_score: int) -> void:
	score += new_score
	emit_signal("updated")


func set_lives(new_lives: int) -> void:
	lives += new_lives
	emit_signal("died")
