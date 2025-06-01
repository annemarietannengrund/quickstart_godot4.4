class_name GameTimerControl extends BasicControl

@onready var ticks_label: Label = %Ticks
@onready var pause_button: Button = %PauseButton
@onready var normal_button: Button = %NormalButton
@onready var fast_button: Button = %FastButton
@onready var faster_button: Button = %FasterButton
var pause_button_mode: GameTimer.PauseGame
var ticks:int = 0
var speeds: Dictionary[GameTimerData.Speed, Button]
func _ready():
	speeds = {
		GameTimerData.Speed.NORMAL: normal_button, 
		GameTimerData.Speed.FAST: fast_button, 
		GameTimerData.Speed.FASTER: faster_button
	}
	connection_map = [
		[SignalBus.timer_control_data, _update_timer_data],
		[SignalBus.pause_game, toggle_paused_display],
		[pause_button.pressed, SignalBus.pause_game.emit.bind(GameTimer.PauseGame.REQUESTED)],
		[SignalBus.speed_changed, speed_changed_signal],
		[normal_button.pressed, SignalBus.speed_change.emit.bind(GameTimerData.Speed.NORMAL)],
		[fast_button.pressed, SignalBus.speed_change.emit.bind(GameTimerData.Speed.FAST)],
		[faster_button.pressed, SignalBus.speed_change.emit.bind(GameTimerData.Speed.FASTER)]
	]
	connect_signals()
	# or
	#connect_signal()
	_update_states_labels()
	SignalBus.timer_control_ready.emit()
	
func speed_changed_signal(new_speed: GameTimerData.Speed):
	for speed_option in speeds.values():
		speed_option.remove_theme_color_override('font_color')
		speed_option.remove_theme_color_override('font_focus_color')
	
	speeds[new_speed].set("theme_override_colors/font_color", "008b60")
	speeds[new_speed].set("theme_override_colors/font_focus_color", "008b60")
	speeds[new_speed].set("theme_override_colors/font_hover_color", "008b60")
	speeds[new_speed].set("theme_override_colors/font_hover_pressed_color", "008b60")
	speeds[new_speed].set("theme_override_colors/font_pressed_color", "008b60")
		
func toggle_paused_display(pause_mode: GameTimer.PauseGame):
	if pause_button_mode == pause_mode or GameTimer.PauseGame.REQUESTED == pause_mode:
		return
	match pause_mode:
		GameTimer.PauseGame.ACTIVATED:
			pause_button_mode = GameTimer.PauseGame.ACTIVATED
			# red
			pause_button.set("theme_override_colors/font_color", "c34252")
			pause_button.set("theme_override_colors/font_focus_color", "c34252")
			
			
			pause_button.set("theme_override_colors/font_hover_color", "008b60")
			pause_button.set("theme_override_colors/font_hover_pressed_color", "008b60")
			pause_button.set("theme_override_colors/font_pressed_color", "008b60")
		GameTimer.PauseGame.DEACTIVATED:
			pause_button_mode = GameTimer.PauseGame.DEACTIVATED
			# green
			pause_button.set("theme_override_colors/font_color", "008b60")
			pause_button.set("theme_override_colors/font_focus_color", "008b60")
			
			pause_button.set("theme_override_colors/font_hover_color", "c34252")
			pause_button.set("theme_override_colors/font_hover_pressed_color", "c34252")
			pause_button.set("theme_override_colors/font_pressed_color", "c34252")
		

func _update_timer_data(update_game_timer:GameTimer):
	ticks = update_game_timer.get_ticks()
	toggle_paused_display(update_game_timer.PauseGame.ACTIVATED if update_game_timer.paused else update_game_timer.PauseGame.DEACTIVATED)
	speed_changed_signal(update_game_timer.game_timer_data.game_speed)
	_update_states_labels()
	
func _update_states_labels():
	ticks_label.text = str(ticks)
	
func _process(_delta):
	pass
