extends Node

var total_time = 0

func add_to_total_time(time):
	total_time += time

func get_total_time():
	return _format_time(total_time)
	
func _format_time(durationInMillis) -> String:
	var millis = int((durationInMillis % 1000) / 100)
	var second = (durationInMillis / 1000) % 60
	var minute = (durationInMillis / (1000 * 60)) % 60

	return "%02d:%02d.%1d" % [minute, second, millis]
