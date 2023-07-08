extends CanvasLayer


func _on_play_button_pressed():
	#When play is pressed, invoke the scene transition global node, and change the scene
	SceneTransition.change_scene("res://Level/test_scene.tscn")
