extends CharacterBody3D
@onready var navigation_agent :NavigationAgent3D

var SPEED := 25.0
var push_force = 30.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var index := 0
var boundaries: Array[Algorithms.Boundary]
var path:PackedVector3Array;

var destination_reached:bool = false;
var new_target_selected:bool = false;

@onready var camera_3d = $Camera3D

func _ready():
	navigation_agent = NavigationAgent3D.new()
	add_child(navigation_agent)
	
	navigation_agent.radius = 1.0
	navigation_agent.height = 0.8
	navigation_agent.path_postprocessing = NavigationPathQueryParameters3D.PATH_POSTPROCESSING_EDGECENTERED
	
	navigation_agent.debug_enabled = true
	navigation_agent.debug_use_custom = true
	navigation_agent.debug_path_custom_color = Color.LIGHT_SEA_GREEN
	navigation_agent.debug_path_custom_point_size = 4

	
	Events.parking_location_selected.connect(_on_parking_location_selected)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()
	
	if destination_reached or not new_target_selected: return
	
	if global_position.distance_squared_to(boundaries[-1].point)<0.5:
		Events.parking_location_reached.emit()
		destination_reached = true
		new_target_selected = false
		return
	
	var target_point = boundaries[index].point
	var target_boundary = boundaries[index].plane
	
	if target_boundary.distance_to(global_position) < 0.5:
		if index < boundaries.size()-1:
			index += 1
			return

	var new_velocity := (target_point-global_position).normalized()*SPEED
	velocity = velocity.lerp(new_velocity, 0.3)
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 0.08)
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
func _on_parking_location_selected(position: Vector3):
	navigation_agent.target_position = position
	if navigation_agent.is_navigation_finished():
		return
	
	path.clear()
	boundaries.clear()
	destination_reached = true # needed for cases when car parking location is changed but path to the new location could not be obtained
	index =0
	path = navigation_agent.get_current_navigation_path()
	if path.is_empty(): 
		push_error("Path is empty. Current Position: %s Target Position: %s" % [global_position , navigation_agent.target_position])
		return
	boundaries = Algorithms.generate_boundary_planes(path)
	
	new_target_selected = true
	destination_reached = false
	
	return
	
func set_camera_current():
	camera_3d.current = true

func reset_camera_current():
	camera_3d.current = false
