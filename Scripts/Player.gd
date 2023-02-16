extends CharacterBody2D

signal player_dead

@export var speed := 600.0
@export var jump_power := 550.0
@export_range(0, 1) var wall_slide_factor := 0.5
@export_range(0.1, 3) var wall_stick_time := 1.0

const MAX_HEALTH = 10.0
var health: float = MAX_HEALTH
var is_level_flipped = false

var current_wall_slide_factor: float

## start debug
var debugLabel: Label
var counter = 0
## end debug

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	debugLabel = get_parent().get_node("HUD/DebugLabel")
	get_parent().flip_level.connect(func(): is_level_flipped = true)
	
	$WallStickTimer.timeout.connect(func():
#		current_wall_slide_factor = 1
#		position.x += get_wall_normal().x * 10
		pass
	)
	
func _process(delta: float) -> void:
	modulate = Color.WHITE.lerp(Color.RED, 1- float(health) / MAX_HEALTH)
	if(health <= 0):
		emit_signal("player_dead")
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		## change falling speed to slide on walls
		if is_on_wall() and velocity.y > 0:
			current_wall_slide_factor = wall_slide_factor
			if $WallStickTimer.time_left <= 0:
				$WallStickTimer.start(wall_stick_time)
		else:
			current_wall_slide_factor = 1
		# Add the gravity.
		velocity.y += gravity * delta * current_wall_slide_factor
	else:
		if is_level_flipped:
			health -= delta
			set_debug(health)
		
		# change moving direction
		var x = speed if (velocity.x > 0) else -speed
		if velocity.x == 0 and get_wall_normal() != Vector2.ZERO:
			x = get_wall_normal().x * speed
		velocity.x = x

	# Handle Jump.
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_action_just_pressed("ui_accept") :
#	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = -jump_power
			# change x speed when jumping, it depends on jump power
			velocity.x = sign(velocity.x) * cos(deg_to_rad(60)) * jump_power
			# $AudioStreamPlayer.play()
		elif is_on_wall():
			var jump_angle := 60 if (get_wall_normal() == Vector2.LEFT) else 120
			velocity = Vector2.LEFT.rotated(deg_to_rad(jump_angle)).normalized() * jump_power
			$AudioStreamPlayer.play()

	move_and_slide()

func get_hit():
	health -= 1
	
func set_debug(s):
		debugLabel.text = str(s)
