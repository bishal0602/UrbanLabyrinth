extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("left")):
		rotation.y = lerp(rotation.y, rotation.y + 3, 0.02)
	elif(Input.is_action_pressed("right")):
		rotation.y = lerp(rotation.y, rotation.y - 3, 0.02)
	elif(Input.is_action_pressed("front")):
		position.z = lerp(position.z, position.z - 10, 0.05)
	elif(Input.is_action_pressed("back")):
		position.z = lerp(position.z, position.z + 10, 0.05)
	elif(Input.is_action_pressed("up")):
		position.y = lerp(position.y, position.y + 10, 0.05)
	elif(Input.is_action_pressed("down")):
		position.y = lerp(position.y, position.y - 10, 0.05)
	pass
