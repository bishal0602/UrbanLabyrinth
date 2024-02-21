extends CharacterBody3D


#const SPEED = 10.0
const JUMP_VELOCITY = 30
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var movement_speed: float = 35.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()
		
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	print(new_velocity)
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	#var to_look_at = Vector3(global_position.x + velocity.x,global_position.y, global_position.z+velocity.z)
	#look_at(lerp(global_position, to_look_at, 0.01), Vector3.UP)
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), 0.1)
	move_and_slide()
