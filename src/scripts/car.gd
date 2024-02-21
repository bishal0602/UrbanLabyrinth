extends VehicleBody3D

@onready var camera_3d = $Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = Input.get_axis("right", "left")
	engine_force = Input.get_axis("back", "front") * 200
	pass


#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#@export var movement_speed: float = 35.0
#@export var steering_factor = 0.05
#@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
#
#func _ready() -> void:
	#navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
#
#func set_movement_target(movement_target: Vector3):
	#navigation_agent.set_target_position(movement_target)
#
##func _physics_process(delta):
	### Add the gravity.
	##
	##var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	##var direction = global_position.direction_to(next_path_position)
	##var dot = linear_velocity.normalized().dot(direction)
	##var ang = acos(dot)
	##
	##print(ang)
	##steering = lerp_angle(steering, ang * steering_factor, 0.1)
		###if navigation_agent.avoidance_enabled:
			###navigation_agent.set_velocity(new_velocity)
		###else:
			###_on_velocity_computed(new_velocity)
##
##func _on_velocity_computed(safe_velocity: Vector3):
	###var to_look_at = Vector3(global_position.x + velocity.x,global_position.y, global_position.z+velocity.z)
	###look_at(lerp(global_position, to_look_at, 0.01), Vector3.UP)
##
	##steering = lerp_angle(steering, atan2(-safe_velocity.x, -safe_velocity.z), 0.1)
#
#func _physics_process(delta):
	## Add the gravity.
	##if not is_on_floor():
		##velocity.y -= gravity * delta
		##move_and_slide()
		#
	#if navigation_agent.is_navigation_finished():
		#return
#
	#var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	#var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	#print(new_velocity)
	#if navigation_agent.avoidance_enabled:
		#navigation_agent.set_velocity(new_velocity)
	#else:
		#_on_velocity_computed(new_velocity)
#
#func _on_velocity_computed(safe_velocity: Vector3):
	#linear_velocity = lerp(linear_velocity, safe_velocity, 0.1)
	##var to_look_at = Vector3(global_position.x + velocity.x,global_position.y, global_position.z+velocity.z)
	##look_at(lerp(global_position, to_look_at, 0.01), Vector3.UP)
	##rotation.y = lerp_angle(rotation.y, atan2(-linear_velocity.x, -linear_velocity.z), 0.1)
	##move_and_slide()
