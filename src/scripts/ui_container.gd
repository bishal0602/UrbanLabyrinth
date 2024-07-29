extends AspectRatioContainer
@onready var press_p_tool_tip = $PressPToolTip
@onready var press_xn_p_tool_tip: TextureRect = $PressXnPToolTip

func _ready():
	Events.ui_set_parking.connect(_on_ui_set_parking)
	Events.ui_set_drive.connect(_on_ui_set_drive)	
	Events.parking_location_reached.connect(on_parking_location_reached)
	Events.parking_location_selected.connect(on_parking_location_selected)
	press_p_tool_tip.visible = false

func _on_ui_set_parking():
	press_p_tool_tip.visible = false
	press_xn_p_tool_tip.visible = false
	
func _on_ui_set_drive():
	press_p_tool_tip.visible = true
	press_xn_p_tool_tip.visible = false
	
func on_parking_location_reached():
	press_p_tool_tip.visible = true
	press_xn_p_tool_tip.visible = false
	
func on_parking_location_selected():
	press_p_tool_tip.visible = false
	press_xn_p_tool_tip.visible = false
