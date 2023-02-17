extends Node2D

@export var destroy_when_flip := false
@export var is_animated := false
@export var move_direction := MoveDirection.Horizontally
@export var two_way_collision := false

enum MoveDirection {
	Horizontally,
	Vertically
}

var leftCollider
var rightCollider
var spike1
var spike2

func _ready() -> void:
	get_parent().get_parent().flip_level.connect(switch_platforms)
	$Platform/Center.one_way_collision = not two_way_collision
	leftCollider = $Platform/Left
	rightCollider = $Platform/Right
	spike1 = $Platform/Spike
	spike2 = $Platform/Spike2
	
	get_child(0).remove_child(leftCollider)
	get_child(0).remove_child(rightCollider)
	get_child(0).remove_child(spike1)
	get_child(0).remove_child(spike2)
	
	if is_animated:
		$AnimationPlayer.play("move_horizontally" if move_direction == MoveDirection.Horizontally else "move_vertically")
		$AnimationPlayer.advance(randf_range(0, 5))

func switch_platforms():
	leftCollider.show()
	rightCollider.show()
	spike1.show()
	spike2.show()
	
	get_child(0).call_deferred("add_child", leftCollider)
	get_child(0).call_deferred("add_child", rightCollider)
	get_child(0).call_deferred("add_child", spike1)
	get_child(0).call_deferred("add_child", spike2)
	
	if destroy_when_flip:
		queue_free()

	get_child(0).remove_child($Platform/Center)
