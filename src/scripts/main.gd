extends Node3D

@onready var car = $car

# mocking target changes
@onready var target1: Node3D = $target1
@onready var target2: Node3D = $target2
@onready var targets:=[target1, target2]
@onready var index = 0


func _ready():
		set_physics_process(false)
		call_deferred("setup")

func setup():
		# Wait for the first physics frame so the NavigationServer can sync.
		await get_tree().physics_frame
		set_physics_process(true)

func _input(event):
# Just mocking user input for testing
	if event.is_action_pressed("ui_accept"):
		index = wrapi(index+1,0,targets.size())
		car.navigation_agent.set_target_position(targets[index].global_position)
		Events.parking_location_selected.emit()
			
