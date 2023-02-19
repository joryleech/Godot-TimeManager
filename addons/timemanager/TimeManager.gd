extends Node
class_name TimeManager

signal on_time_is_changed()
signal on_time_is_passed(int)
signal on_day_is_changed(int)

@export var timePeriods : Array[Resource] = []
@export var defaultTimePeriodIndex : int = 0

var _currentTimePeriodIndex = 0
var _currentDay = 0

func _ready():
	_currentTimePeriodIndex = defaultTimePeriodIndex

func pass_time_by_steps(steps):
	_currentTimePeriodIndex += steps
	if(_currentTimePeriodIndex >= len(timePeriods)):
		_currentDay += floor(_currentTimePeriodIndex/len(timePeriods))
		_currentTimePeriodIndex = _currentTimePeriodIndex % len(timePeriods)
	emit_signal('on_time_is_passed', steps)
	emit_signal('on_time_is_changed')
	
func changeDay(delta_day : int):
	_currentDay += floor(_currentTimePeriodIndex/len(timePeriods))
	emit_signal("on_day_is_changed", delta_day)
	
func get_current_time():
	return timePeriods[_currentTimePeriodIndex]
	
func get_current_day():
	return _currentDay
	
func get_current_time_index():
	return _currentTimePeriodIndex
	
func get_times():
	return timePeriods
	
func serialize():
	return {
		"_currentTimePeriodIndex":_currentTimePeriodIndex,
		"_currentDay": _currentDay
	}

func deserialize(json : Dictionary):
	_currentTimePeriodIndex = json.get("_currentTimePeriodIndex", _currentTimePeriodIndex)
	_currentDay = json.get("_currentDay", _currentDay)
	emit_signal('on_time_is_changed')
