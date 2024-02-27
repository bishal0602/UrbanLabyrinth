extends CharacterBody3D
@onready var navigation_agent :NavigationAgent3D= $NavigationAgent3D
var index := 0
var boundaries: Array[Algorithms.Boundary]
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var path:PackedVector3Array;

var destination_reached:bool = false;
var new_target_selected:bool = false;

func _ready():
	Events.parking_location_selected.connect(_on_parking_location_selected)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		move_and_slide()
	
	if destination_reached or not new_target_selected: return
	
	if global_position.distance_squared_to(boundaries[-1].point)<0.5:
		destination_reached = true
		new_target_selected = false
		return
	
	var target_point = boundaries[index].point
	var target_boundary = boundaries[index].plane
	
	if target_boundary.distance_to(global_position) < 0.5:
		if index < boundaries.size()-1:
			index += 1
			return

	var new_velocity := (target_point-global_position).normalized()*20.0
	velocity = velocity.lerp(new_velocity, 0.3)
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 0.08)
	move_and_slide()
	
func _on_parking_location_selected():
	if navigation_agent.is_navigation_finished():
		return
	
	path.clear()
	boundaries.clear()
	path = navigation_agent.get_current_navigation_path()
	boundaries = Algorithms.generate_boundary_planes(path)
	
	new_target_selected = true
	destination_reached = false
	
	return
