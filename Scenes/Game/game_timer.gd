class_name GameTimer extends Timer

@export var game_timer_data: GameTimerData
enum PauseGame { REQUESTED, ACTIVATED, DEACTIVATED }

func _ready() -> void:
	game_timer_data = GameTimerData.new()
	SignalBus.timer_control_ready.connect(_on_timeer_control_ready)
	SignalBus.pause_game.connect(_toggle_pause)
	SignalBus.speed_change.connect(_toggle_game_speed)
	start()
	paused = true

func _toggle_game_speed(speed_request:GameTimerData.Speed):
	game_timer_data.game_speed = speed_request
	match speed_request:
		GameTimerData.Speed.NORMAL:
			wait_time = 1.0
		GameTimerData.Speed.FAST:
			wait_time = 0.1
		GameTimerData.Speed.FASTER:
			wait_time = 0.01
	stop()
	start()
	SignalBus.speed_changed.emit(speed_request)
	
func _toggle_pause(pause_request:PauseGame):
	if pause_request != PauseGame.REQUESTED:
		return
	paused = !paused
	SignalBus.pause_game.emit(PauseGame.ACTIVATED if paused else PauseGame.DEACTIVATED)

func _exit_tree() -> void:
	SignalBus.timer_control_ready.disconnect(_on_timeer_control_ready)
	SignalBus.pause_game.disconnect(_toggle_pause)
	SignalBus.speed_change.disconnect(_toggle_game_speed)
	queue_free()
	
func _process(delta: float) -> void:
	game_timer_data.realtime += delta

func on_load_game(savegame: Savegame):
	paused = true
	for data in savegame.data:
		if data is not GameTimerData:
			continue
		game_timer_data = data
		SignalBus.timer_control_data.emit(self)
		_toggle_game_speed(game_timer_data.game_speed)

func _on_timeer_control_ready():
	SignalBus.timer_control_data.emit(self)

func on_save_game(savegame: Savegame):
	savegame.data.append(game_timer_data)

func _on_timeout() -> void:
	game_timer_data.ticks += 1
	SignalBus.timer_control_data.emit(self)

func get_ticks() -> int:
	return game_timer_data.ticks
