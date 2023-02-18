extends Control

func _ready() -> void:
	var text = $Label.text
	print($Label.text)
	$Label.text = text.replace("TOTAL_TIME", TimeCounter.get_total_time())
