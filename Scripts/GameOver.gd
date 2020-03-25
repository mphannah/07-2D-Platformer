extends Control

onready var data = get_node("/root/PlayerData")

func _on_Retry_pressed():
	data.reset()
	get_tree().change_scene("res://Scenes/World.tscn")



func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
