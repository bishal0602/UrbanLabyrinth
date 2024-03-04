extends Node3D

# mocking target changes
@onready var target1: Node3D = $target1
@onready var target2: Node3D = $target2
@onready var target3: Node3D = $target3
@onready var target4: Node3D = $target4
@onready var target5: Node3D = $target5

@onready var targets:=[target1, target2, target3, target4, target5]
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
	if(event.is_action_pressed("park")):
		Events.ui_set_parking.emit()
		
	if(event.is_action_pressed("escape")):
		Events.ui_set_main.emit()
		
	if event.is_action_pressed("ui_accept"):
		index = wrapi(index+1,0,targets.size())
		print(index)
		Events.parking_location_selected.emit(targets[index].global_position)
	
