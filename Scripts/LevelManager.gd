extends Node2D
"""
	add win conditions
"""
signal flip_level
signal player_won
signal player_lose

@export var platform: PackedScene

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_P:
			emit_signal("flip_level")



func _on_level_top_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$LevelEndTriggers/LevelTop.queue_free()
		emit_signal("flip_level")


func _on_level_bottom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$LevelEndTriggers/LevelBottom.queue_free()
#		end_game()


func _on_player_player_dead() -> void:
	$Player.queue_free()
	emit_signal("player_lose")
