extends Node3D

@onready var astar = $AStar
@onready var player:CharacterBody3D = $player
@onready var camera:Camera3D = $Camera3D
#@onready var marker = $Marker


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var e: InputEventMouseButton = event
		var from := camera.project_ray_origin(e.position)
		var to := camera.project_ray_normal(e.position) * 1000

		var space_state := get_world_3d().direct_space_state
		var result := space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
		if result != null and not result.is_empty():
			player.update_path(astar.find_path(player.global_transform.origin, result.position))
			#marker.global_transform.origin = result.position
