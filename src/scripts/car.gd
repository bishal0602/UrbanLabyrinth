extends CharacterBody3D
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
	
	var new_velocity := (target-global_position).normalized()*20
	velocity = velocity.lerp(new_velocity, 0.3)
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 0.08)
	move_and_slide()
			
#
