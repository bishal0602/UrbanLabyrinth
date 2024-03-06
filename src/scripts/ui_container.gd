extends AspectRatioContainer
@onready var pressPToolTip:TextureRect= $PressPToolTip

func _ready():
	Events.ui_set_parking.connect(_on_ui_set_parking)
	Events.parking_location_reached.connect(on_parking_location_reached)

func _on_ui_set_parking():
	pressPToolTip.visible = false

func on_parking_location_reached():
	print("Parked!")
