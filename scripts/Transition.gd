extends Node

var next_path
var above_node
var _params = {}

func fade_to(path, params=null):
	if params != null:
		for key in params:
			_params[key] = params[key]
	next_path = path
	get_node("Animation").play("Fade")


func change_scene():
	if next_path != null:
		get_tree().change_scene(next_path)

func put_above(path):
	if above_node != null:
		return
	get_tree().set_pause(true)
	above_node = load(path).instance()
	get_tree().get_root().add_child(above_node)

func clear_above():
	if above_node == null: 
		return
	get_tree().set_pause(false)
	get_tree().get_root().remove_child(above_node)
	above_node = null
	
func get_param(name):
	if _params != null and _params != {} and _params.has(name):
		return _params[name]
	return null
	
func set_param(name, value):
	if _params != null and _params != {} and _params.has(name):
		_params[name] = value