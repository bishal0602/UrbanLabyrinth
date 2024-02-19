extends Node3D
@onready var player :CharacterBody3D = $player
@onready var target :Node3D = $target
"""
@onready var map_viewport :SubViewport = $UI/SubViewportContainer/SubViewport
@onready var map_camera:Camera3D = $UI/SubViewportContainer/SubViewport/Camera3D
"""

var map_viewport_bounding := Vector2.ZERO

func _ready():
	"""
	get_tree().get_root().size_changed.connect(Callable(_on_screen_resized))
	map_viewport_bounding = Vector2(get_viewport().size.x-map_viewport.size.x , map_viewport.size.y)
	"""
		
	set_physics_process(false)
	call_deferred("setup")
		

func setup():
		# Wait for the first physics frame so the NavigationServer can sync.
		await get_tree().physics_frame
		set_physics_process(true)

func _physics_process(delta):
		#get_tree().call_group("enemies", "set_movement_target", player.global_transform.origin)
		player.set_movement_target(target.global_transform.origin)
		
"""
func _on_screen_resized():
	map_viewport_bounding = Vector2(get_viewport().size.x-map_viewport.size.x , map_viewport.size.y)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
			var e: InputEventMouseButton = event
			#if(e.position.x>map_viewport_bounding.x&&e.position.y<map_viewport_bounding.y):	
			if true:
				var mapped_position := Vector2(((e.position.x-map_viewport_bounding.x) / map_viewport.size.x)*get_viewport().size.x, (e.position.y / map_viewport.size.y)*get_viewport().size.y)
				var from := map_camera.project_ray_origin(mapped_position)
				var to := map_camera.project_ray_normal(mapped_position) * 1000
				#line(Vector3(-10,100,-100), Vector3(0, -100, -100), Color.RED)
				line(from, to, Color.RED)
				print(event.position,mapped_position, from, to)
				#var space_state := get_world_3d().direct_space_state
				#var result := space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
				#if result != null and not result.is_empty():
					#print(result.position)
					#player.set_movement_target(result.position)
						#marker.global_transform.origin = result.position

	
func line(pos1: Vector3, pos2: Vector3, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color

	return await final_cleanup(mesh_instance, persist_ms)
	
func final_cleanup(mesh_instance: MeshInstance3D, persist_ms: float):
	get_tree().get_root().add_child(mesh_instance)
	if persist_ms == 1:
		await get_tree().physics_frame
		mesh_instance.queue_free()
	elif persist_ms > 0:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance
"""
