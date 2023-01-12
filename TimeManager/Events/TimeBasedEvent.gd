extends Node
signal on_disable
signal on_enable

@export var timeManagerRef : TimeManager
@export var activePeriods : Array[Resource] = []
@export var manage_children : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	timeManagerRef.on_time_is_changed.connect(check_time)
	check_time()

func is_enabled():
	var current_time = timeManagerRef.get_current_time()
	print(current_time)
	print( activePeriods.find(current_time))
	return activePeriods.find(current_time) != -1
	
func check_time():
	if(is_enabled()):
		_enable()
	else:
		_disable()

func _disable():
	_disable_children()
	emit_signal("on_disable")
	
func _enable():
	_enable_children()
	emit_signal("on_enable")

var _stored_children_nodes = []
func _enable_children():
	if(manage_children):
		for _i in _stored_children_nodes:
			add_child(_i)
	_stored_children_nodes = []

func _disable_children():
	if(manage_children):
		for _i in self.get_children():
			_stored_children_nodes.push_back(_i)
			remove_child(_i)
