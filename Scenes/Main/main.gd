class_name MainSM extends SceneManagerBase

enum Scene { MAIN_MENU, APP_SETTINGS, APP_PROFILE, GAME_PLANNER, NEW_GAME }
@export var main_menu: PackedScene
@export var settings: PackedScene
@export var profile: PackedScene
@export var game_planner: PackedScene
@export var game_main_scene: PackedScene

func _ready():
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_SETTINGS)
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_PROFILE)
	TranslationServer.set_locale(Globals.language_map[App.config.active_language])
	register_scene(_gev(Scene.MAIN_MENU), main_menu)
	register_scene(_gev(Scene.APP_SETTINGS), settings)
	register_scene(_gev(Scene.APP_PROFILE), profile)
	register_scene(_gev(Scene.GAME_PLANNER), game_planner)
	connect_signal(SignalBus.change_scene, change_scene)
	connect_signal(SignalBus.new_game, change_to_new_game_scene)
	connect_signal(SignalBus.load_game, change_to_load_game_scene)
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

func change_to_load_game_scene():
	NodeHelper.remove_children(content_node)
	var game_node = game_main_scene.instantiate()
	# put game configuration here
	content_node.add_child(game_node)
	
	# load savegame data with saverloader
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_GAME)
	
func change_to_new_game_scene(new_game_planner_data: GamePlanner):
	NodeHelper.remove_children(content_node)
	var game_node = game_main_scene.instantiate()
	game_node.game_planner = new_game_planner_data
	# put game configuration here
	content_node.add_child(game_node)
