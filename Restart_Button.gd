extends Button




func _on_Restart_Button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")#put main scene
	

func _on_quit_button_pressed():
	get_tree().quit()
