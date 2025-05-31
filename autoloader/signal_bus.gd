extends Node

signal save_config
signal date_changed
signal change_scene
signal saverloader
signal change_setting

func connect_signals(connection_map:Array) -> void:
	for item in connection_map:
		item[0].connect(item[1])

func connect_signal(new_signal: Signal, method:Callable) -> void:
	new_signal.connect(method)

func disconnect_signals(connection_map:Array) -> void:
	for item in connection_map:
		if not item[1] or not item[0].is_connected(item[1]):  
			continue  
		item[0].disconnect(item[1])

func _nevercall() -> void:
	# add a function emit to stop godot complain about unused signals
	save_config.emit()
	date_changed.emit()
	change_scene.emit()
	saverloader.emit()
	change_setting.emit()
