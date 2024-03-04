extends Control

func _ready():
	visible = false
	Events.ui_set_parking.connect(_on_ui_set_parking)
	Events.ui_set_main.connect(_on_ui_set_main)
	
func _on_ui_set_parking():
	visible = true

func _on_ui_set_main():
	visible = false
	
func _input(event):
	if not visible: return
	
	#TODO: Add Parking Selection


func _on_love_garden_parking_mouse_entered():
	var container:SubViewportContainer = $GridContainer/LoveGardenParking
	#container.
