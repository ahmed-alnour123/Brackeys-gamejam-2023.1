extends CanvasLayer

var levels = [
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn",
	"res://Scenes/Levels/Level3.tscn",
	"res://Scenes/Levels/Level4.tscn",
	"res://Scenes/Levels/Level5.tscn",
	"res://Scenes/Levels/Level6.tscn",
]

func _ready() -> void:
	get_parent().player_won.connect(func(): $LevelClearedMenu.show())
	get_parent().player_lose.connect(func(): $GameoverMenu.show())

func _on_restart_button_button_down() -> void:
	get_tree().reload_current_scene()


func _on_next_level_button_button_down() -> void:
	var scene_name = "res://Scenes/Levels/" + get_tree().root.get_child(1).name + ".tscn"
	var index = levels.find(scene_name)
	var next_scene = levels[index + 1] if (index < levels.size() - 1 and index != -1) else "res://Scenes/GameEnd.tscn"
	get_tree().change_scene_to_file(next_scene)
