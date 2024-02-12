extends Node3D

@onready var player :CharacterBody3D = $player

func _ready():
	set_physics_process(false)
	call_deferred("enemies_setup")

func enemies_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta):
		get_tree().call_group("enemies", "set_movement_target", player.global_transform.origin)
