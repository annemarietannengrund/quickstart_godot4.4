class_name MainMenuScene extends BasicControl

@onready var quit: Button = %QUIT
@onready var profile: Button = %PROFILE
@onready var settings: Button = %SETTINGS
@onready var continue_game: Button = %CONTINUE_GAME
@onready var new_game: Button = %NEW_GAME

func _ready():
	connection_map = [
		[quit.pressed, get_tree().quit],
		[settings.pressed, MainSM.change_to_app_settings_scene],
		[profile.pressed, MainSM.change_to_app_profile_scene],
		[continue_game.pressed, SignalBus.load_game.emit],
		[new_game.pressed, MainSM.change_to_game_planner_scene]
	]
	if not FileAccess.file_exists(Globals.get_savegame_path_for(App.user_profile.profile_id)):
		continue_game.disabled = true
	connect_signals()
