extends Control

func _ready():
	visible = false
	Events.ui_set_parking.connect(_on_ui_set_parking)
	Events.ui_set_main.connect(_on_ui_set_main)
	Events.ui_set_drive.connect(_on_ui_set_drive)
	
func _on_ui_set_parking():
	visible = true

func _on_ui_set_main():
	visible = false
	
func _on_ui_set_drive():
	visible = false


func _on__ictc_parking_pressed():
	Events.parking_location_selected.emit(Vector3(33.7,-3.4,-37.1))
	Events.ui_set_main.emit()

func _on_robotics_parking_pressed():
	Events.parking_location_selected.emit(Vector3(-72.346, 0, -46.124))
	Events.ui_set_main.emit()
	
func _on_bct_parking_pressed():
	Events.parking_location_selected.emit(Vector3(13.6,0,-161.8))
	Events.ui_set_main.emit()

func on_lovegarden_parking_pressed():
	Events.parking_location_selected.emit(Vector3(-191.5,0, -169))
	Events.ui_set_main.emit()
