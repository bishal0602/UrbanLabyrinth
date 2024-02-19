extends VehicleBody3D

@onready var camera_pivot = $CameraPivot
@onready var camera_3d = $CameraPivot/Camera3D
#@onready var reverse_camera = $CameraPivot/ReverseCamera

var look_at

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(steering, engine_force)
	steering = Input.get_axis("right", "left")
	engine_force = Input.get_axis("back", "front") * 100
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0 )
	#_check_camera_switch()
	pass

#func _check_camera_switch():
	#if(linear_velocity.dot(transform.basis.z) > 0):
		#camera_3d.current = true
		#reverse_camera.current = false
	#else:
		#reverse_camera.current = true
		#camera_3d.current = false
