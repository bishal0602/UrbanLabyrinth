extends Node3D

@export var should_draw_cubes := false
var grid_size := 1.0
var grid_y := 0.5
var points :Dictionary= {}
var astar := AStar3D.new()
var cube_mesh := BoxMesh.new()
var red_material := StandardMaterial3D.new()
var green_material := StandardMaterial3D.new()

func _ready():
	red_material.albedo_color = Color.RED
	green_material.albedo_color = Color.GREEN
	cube_mesh.size = Vector3(0.25, 0.25, 0.25)
	var traversables := get_tree().get_nodes_in_group("traversable")
	_add_points(traversables)
	_connect_points()

func _add_points(traversables: Array[Node]):
	for traversable in traversables:
		var mesh : MeshInstance3D = traversable.get_node("MeshInstance3D")
		var aabb := mesh.global_transform*mesh.get_aabb()
		var start_point := aabb.position		
		var x_steps := aabb.size.x / grid_size
		var z_steps := aabb.size.z / grid_size
		
		for x in x_steps:
			for z in z_steps:
				var next_point := start_point + Vector3(x * grid_size, 0, z * grid_size)
				_add_point(next_point)
		
		
func _add_point(point:Vector3):
	point.y = grid_y	
	var id := astar.get_available_point_id()
	astar.add_point(id, point)
	points[world_coord_to_astar(point)] = id
	_create_nav_cube(point)

	
func _connect_points():
	for point in points:
		var pos_str = point.split(",")
		var world_pos := Vector3(int(pos_str[0]),int(pos_str[1]), int(pos_str[2]))
		var search_coords := [-grid_size,0,grid_size]
		for x in search_coords:
			for z in search_coords:
				var search_offset := Vector3(x,0,z)
				if(search_offset == Vector3.ZERO):
					continue
				
				var potential_neighbor := world_coord_to_astar(world_pos+search_offset)
				if points.has(potential_neighbor):
					var current_id = points[point]
					var neighbor_id = points[potential_neighbor]
					if not astar.are_points_connected(current_id, neighbor_id):
						astar.connect_points(current_id, neighbor_id)
						if should_draw_cubes:
							get_child(current_id).material_override = green_material
							get_child(neighbor_id).material_override = green_material

func find_path(from:Vector3, to:Vector3)-> PackedVector3Array:
	var start_id = astar.get_closest_point(from)
	var end_id = astar.get_closest_point(to)
	
	return astar.get_point_path(start_id, end_id)

func _create_nav_cube(position: Vector3):
	if should_draw_cubes:
		var cube := MeshInstance3D.new()
		cube.mesh = cube_mesh
		cube.material_override = red_material
		add_child(cube)
		position.y = grid_y
		cube.global_position = position
		
func world_coord_to_astar(world_point: Vector3)->String:
	var x := snappedf(world_point.x, grid_size)
	var y := grid_y
	var z := snappedf(world_point.z, grid_size)	
	return "%d,%d,%d"%[x,y,z]
