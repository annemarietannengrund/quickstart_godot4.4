class_name MainSM extends SceneManagerBase

enum Scene { MAIN_MENU, APP_SETTINGS, APP_PROFILE, GAME_PLANNER }
@export var main_menu: PackedScene
@export var settings: PackedScene
@export var profile: PackedScene
@export var game_planner: PackedScene

func _ready():
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_SETTINGS)
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_PROFILE)
	TranslationServer.set_locale(Globals.language_map[App.config.active_language])
	register_scene(_gev(Scene.MAIN_MENU), main_menu)
	register_scene(_gev(Scene.APP_SETTINGS), settings)
	register_scene(_gev(Scene.APP_PROFILE), profile)
	register_scene(_gev(Scene.GAME_PLANNER), game_planner)
	connect_signal(SignalBus.change_scene, change_scene)
	change_to_main_menu()

static func _gev(scene_option:Scene):
	return Scene.keys()[scene_option]

static func change_to_main_menu():
	SignalBus.change_scene.emit(MainSM._gev(Scene.MAIN_MENU))

static func change_to_app_settings_scene():
	SignalBus.change_scene.emit(MainSM._gev(Scene.APP_SETTINGS))

static func change_to_app_profile_scene():
	SignalBus.change_scene.emit(MainSM._gev(Scene.APP_PROFILE))

static func change_to_game_planner_scene():
	SignalBus.change_scene.emit(MainSM._gev(Scene.GAME_PLANNER))
