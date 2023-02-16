extends CanvasLayer

var root

func _ready() -> void:
	root = get_parent().player_won.connect(func(): $LevelClearedMenu.show())
	root = get_parent().player_lose.connect(func(): $GameoverMenu.show())

func _on_restart_button_button_down() -> void:
	get_tree().reload_current_scene()


func _on_next_level_button_button_down() -> void:
	# load next level scene
	pass
