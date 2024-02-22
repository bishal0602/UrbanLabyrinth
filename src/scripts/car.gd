extends VehicleBody3D
@onready var navigation_agent :NavigationAgent3D= $NavigationAgent3D
var index := 0

var path:PackedVector3Array;

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	if path.is_empty():
		path = navigation_agent.get_current_navigation_path()
		return
		
	# do stuff here
	var target = path[index]
	if position.distance_squared_to(target) <1:
		if index < path.size():
			index += 1
	
	var velocity := (target-global_position).normalized()*20
	linear_velocity = linear_velocity.lerp(velocity, 0.3)
			
#
