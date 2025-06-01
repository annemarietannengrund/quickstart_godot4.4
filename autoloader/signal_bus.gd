extends Node

signal save_config
signal date_changed
signal change_scene
signal saverloader
signal change_setting
signal profile
signal changed_profile
signal new_game
signal load_game
signal timer_control_ready
signal timer_control_data
signal pause_game
signal speed_change
signal speed_changed

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
	profile.emit()
	changed_profile.emit()
	new_game.emit()
	load_game.emit()
	timer_control_ready.emit()
	timer_control_data.emit()
	pause_game.emit()
	speed_change.emit()
	speed_changed.emit()
