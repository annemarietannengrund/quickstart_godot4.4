class_name SettingsManager extends BasicControl

enum Setting { LANGUAGE }

func _ready():
	handle_no_config()
	#connection_map = []
	connect_signal(SignalBus.change_setting, change_setting)
	# or
	#connect_signal()

func change_setting(setting_type, setting_value):
	match Setting[Setting.find_key(setting_type)]:
		Setting.LANGUAGE: 
			App.config.active_language = setting_value
			# set the translation server to the new language code
			TranslationServer.set_locale(Globals.language_map[App.config.active_language])
	# signal for a save of the settings file
	SignalBus.saverloader.emit(SaverLoader.Action.SAVE_SETTINGS)

func handle_no_config():
	if App.config is SettingsData:
		return
	App.config = SettingsData.new()
	
func _process(_delta):
	pass
