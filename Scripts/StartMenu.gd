extends Control

onready var data = get_node("/root/PlayerData")

func _on_NewGame_pressed():
	data.reset()
	get_tree().change_scene("res://Scenes/World.tscn")



func _on_Quit_pressed():
	get_tree().quit()


func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")
