extends Node3D

func _ready():
		set_physics_process(false)
		call_deferred("setup")

func setup():
		# Wait for the first physics frame so the NavigationServer can sync.
		await get_tree().physics_frame
		set_physics_process(true)

func _input(event):
	if(event.is_action_pressed("escape")):
		Events.ui_set_main.emit()
