extends Node3D

@export var root_node:Node3D = self

var navigation_mesh: NavigationMesh
var source_geometry : NavigationMeshSourceGeometryData3D
var callback_parsing : Callable
var callback_baking : Callable
var region_rid: RID

func _ready() -> void:
	navigation_mesh = NavigationMesh.new()
	navigation_mesh.agent_radius = 1.0
	navigation_mesh.agent_height = 0.8
	navigation_mesh.agent_max_slope = 60.0
	navigation_mesh.agent_max_climb = 0.5
	
	
	source_geometry = NavigationMeshSourceGeometryData3D.new()
	callback_parsing = on_parsing_done
	callback_baking = on_baking_done
	region_rid = NavigationServer3D.region_create()

	NavigationServer3D.region_set_enabled(region_rid, true)
	NavigationServer3D.region_set_map(region_rid, get_world_3d().get_navigation_map())
	parse_source_geometry.call_deferred()

func parse_source_geometry() -> void:
	source_geometry.clear()

	NavigationServer3D.parse_source_geometry_data(
		navigation_mesh,
		source_geometry,
		root_node,
		callback_parsing
	)

func on_parsing_done() -> void:
	NavigationServer3D.bake_from_source_geometry_data_async(
		navigation_mesh,
		source_geometry,
		callback_baking
	)

func on_baking_done() -> void:
	NavigationServer3D.region_set_navigation_mesh(region_rid, navigation_mesh)
