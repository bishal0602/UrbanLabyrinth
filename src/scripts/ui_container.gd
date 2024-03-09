extends AspectRatioContainer
@onready var pressPToolTip:TextureRect= $PressPToolTip
@onready var start_screen = $StartScreen

func _ready():
	Events.ui_set_parking.connect(_on_ui_set_parking)
	Events.ui_set_main.connect(_on_ui_set_main)	
	Events.parking_location_reached.connect(on_parking_location_reached)

func _on_ui_set_parking():
	pressPToolTip.visible = false
	start_screen.visible = false
	
func _on_ui_set_main():
	start_screen.visible = false
	
func on_parking_location_reached():
	print("Parked!")
