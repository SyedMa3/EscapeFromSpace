extends Control

func _ready():
	pass

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://World/Level0.tscn")

func _on_ControlsButton_pressed():
	get_tree().change_scene("res://UI/ControlsScreen.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StorylineButton_pressed():
	get_tree().change_scene("res://UI/StorylineScreen.tscn")
