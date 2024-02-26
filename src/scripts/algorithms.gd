extends Node

class Boundary:
	var point: Vector3
	var plane: Plane

	func _init(point: Vector3, plane: Plane):
		self.point = point
		self.plane = plane

func generate_boundary_planes(points:PackedVector3Array) -> Array[Boundary]:
	var boundaries: Array[Boundary];
	var size := points.size()
	#TODO: Check for empty or too less values
	
	var start := points[0]
	var end := points[-1]
	
	var turn_distance := 0.5
	
	for i in size:
		if(i==(size-2)):
			var turning_point = end
			var turn_vector := (points[i]-end).normalized()
			var turn_boundary = Plane(turn_vector,turning_point)
			
			boundaries.push_back(Boundary.new(turning_point, turn_boundary))		
			break 
			
		var a = points[i]
		var b = points[i+1]
		
		var turn_vector := (a-b).normalized()
		var turning_point :Vector3= (b+turn_vector*turn_distance)
		var turn_boundary = Plane(turn_vector, turning_point)

		boundaries.push_back(Boundary.new(turning_point, turn_boundary))
		
	return boundaries
		
	
