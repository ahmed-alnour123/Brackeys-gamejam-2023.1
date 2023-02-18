extends Node2D

signal flip_level
signal player_won
signal player_lose

@export var platform: PackedScene

var start_time = 0
var count_time = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_P:
#			_on_level_top_body_entered($Player)
			pass

func _ready() -> void:
	start_time = Time.get_ticks_msec()
	MusicPlayer.play()

func _process(delta: float) -> void:
	update_timer(delta)

func _on_level_top_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$LevelEndTriggers/LevelTop.queue_free()
		$LevelEndTriggers/LevelBottom.monitoring = true
		$LevelEndTriggers/LevelBottom.show()
		emit_signal("flip_level")


func _on_level_bottom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$LevelEndTriggers/LevelBottom.queue_free()
		win_level()


func _on_player_player_dead() -> void:
#	$Player.queue_free()
	emit_signal("player_lose")
	count_time = false

func win_level():
	# show some animation
	emit_signal("player_won")
	$Player.set_physics_process(false)
	$Player.play_win_sound()
	count_time = false
	# go to next level
	# it will happen from HUD

func update_timer(delta: float) -> void:
	if not count_time: return
	
	var elasped_time = Time.get_ticks_msec() - start_time
	$HUD/GameTimer.text = _format_time(elasped_time)
	
func _format_time(durationInMillis) -> String:
	var millis = int((durationInMillis % 1000) / 100)
	var second = (durationInMillis / 1000) % 60
	var minute = (durationInMillis / (1000 * 60)) % 60

	return "%02d:%02d.%1d" % [minute, second, millis]
