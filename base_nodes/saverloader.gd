class_name SaverLoader extends BasicControl

enum Action { SAVE_GAME, LOAD_GAME, SAVE_SETTINGS, LOAD_SETTINGS, SAVE_PROFILE, LOAD_PROFILE }
func _ready():
	connect_signal(SignalBus.saverloader, _on_saverloader)

func _on_saverloader(action: Action):
	match action:
		Action.SAVE_GAME: _save_game()
		Action.LOAD_GAME: _load_game()
		Action.SAVE_SETTINGS: _save_settings()
		Action.LOAD_SETTINGS: _load_settings()
		Action.SAVE_PROFILE: _save_profile()
		Action.LOAD_PROFILE: _load_profile()

func _load_game():
	get_tree().call_group("on_before_load_game", "on_before_load_game")
	var savegame = ResourceLoader.load(Globals.get_savegame_path_for(App.config.active_profile_id), "Savegame", ResourceLoader.CACHE_MODE_IGNORE)
	get_tree().call_group("on_load_game", "on_load_game", savegame)

func _save_game():
	var savegame = Savegame.new()
	get_tree().call_group("on_save_game", "on_save_game", savegame)
	ResourceSaver.save(savegame, Globals.get_savegame_path_for(App.config.active_profile_id))

func _load_settings():
	var filepath = Globals.APP_CONFIG_FILE_PATH
	if not FileAccess.file_exists(filepath):
		App.config = SettingsData.new()
		_save_settings()
	App.config = ResourceLoader.load(filepath, "Settings", ResourceLoader.CACHE_MODE_IGNORE)

func _save_settings():
	ResourceSaver.save(App.config, Globals.APP_CONFIG_FILE_PATH)

func _load_profile():
	var filepath = Globals.get_profile_path_for(App.config.active_profile_id)
	if not FileAccess.file_exists(filepath):
		App.user_profile = ProfileData.new()
		App.user_profile.profile_id = App.config.active_profile_id
		_save_profile()
	App.user_profile = ResourceLoader.load(filepath, "Settings", ResourceLoader.CACHE_MODE_IGNORE)

func _save_profile():
	var filepath = Globals.get_profile_path_for(App.config.active_profile_id)
	ResourceSaver.save(App.user_profile, filepath)
