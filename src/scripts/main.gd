extends Node3D

@onready var target: Node3D = $target
@onready var car = $car


func _ready():
		set_physics_process(false)
		call_deferred("setup")

func setup():
		# Wait for the first physics frame so the NavigationServer can sync.
		#player.set_movement_target(target.global_position)
		car.set_movement_target(target.global_position)
		await get_tree().physics_frame
		set_physics_process(true)

#func _physics_process(delta):
		##get_tree().call_group("enemies", "set_movement_target", player.global_transform.origin)
		#player.set_movement_target(target.global_position)
