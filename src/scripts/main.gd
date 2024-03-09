extends Node3D

var camera_velocity = 30
@onready var camera_path = $camera_path
@onready var path_follow_3d = $camera_path/PathFollow3D
@onready var panning_camera = $camera_path/PathFollow3D/panning_camera
@onready var car = $car


func _ready():
		set_physics_process(false)
		call_deferred("setup")

func setup():
		# Wait for the first physics frame so the NavigationServer can sync.
		await get_tree().physics_frame
		set_physics_process(true)

func _input(event):
	if(event.is_action_pressed("park")):
		panning_camera.current = false
		car.set_camera_current()
		Events.ui_set_parking.emit()
	if(event.is_action_pressed("go_back")):
		panning_camera.current = false		
		Events.ui_set_main.emit()
	if(event.is_action_pressed("exit")):
		get_tree().quit(0)
	
func _process(delta):
	if(Input.is_key_pressed(KEY_H)):
		path_follow_3d.progress_ratio = 0.5
	path_follow_3d.progress += camera_velocity * delta
