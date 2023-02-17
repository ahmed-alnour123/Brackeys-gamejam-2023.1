extends Control



func _on_play_button_button_down() -> void:
	if name == "HowToPlay":
		# TODO: change to level 1
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")
