extends Control

onready var data = get_node("/root/PlayerData")

func _ready():
	PlayerData.connect("updated", self, "update_interface")
	score()

func _on_Menu_pressed():
	data.reset()
	get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func score():
	$Score.text = "Score %s" % PlayerData.score
