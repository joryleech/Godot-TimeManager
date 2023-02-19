@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("TimeManager","Node",preload("res://addons/timemanager/TimeManager.gd"), preload("res://addons/timemanager/clock.png"))


func _exit_tree():
	remove_custom_type("TimeManager")
	pass
