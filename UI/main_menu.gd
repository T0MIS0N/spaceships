extends CanvasLayer

var level = preload("res://Level/game_world.tscn")

func _on_play_button_pressed():
	#When play is pressed, invoke the scene transition global node, and change the scene
	SceneTransition.change_packed_scene(level)
