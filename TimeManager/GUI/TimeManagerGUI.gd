extends PanelContainer
# Called when the node enters the scene tree for the first time
@export var timeManagerRef : TimeManager

var _time_label : Label
var _day_label : Label
func _ready():
	_day_label = get_node("VBoxContainer/Day Label")
	_time_label = get_node("VBoxContainer/Time Label")
	if(timeManagerRef):
		_attach_time_manager(timeManagerRef)
		
func _attach_time_manager(newTimeManager : TimeManager):
	if timeManagerRef:
		timeManagerRef.on_time_is_changed.disconnect(render)
	timeManagerRef = newTimeManager
	timeManagerRef.on_time_is_changed.connect(render)
	render()

func render():
	_time_label.text = timeManagerRef.get_current_time().name
	_day_label.text = "Day "+str(timeManagerRef.get_current_day())
	


