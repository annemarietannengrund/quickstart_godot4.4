class_name MainSM extends SceneManagerBase

enum Scene { MAIN_MENU, SCENES }
@export var main_menu: PackedScene
@export var scenes_scene: PackedScene

func _ready():
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_SETTINGS)
	SignalBus.saverloader.emit(SaverLoader.Action.LOAD_PROFILE)
	TranslationServer.set_locale(Globals.language_map[Globals.Language.ENGLISH])
	register_scene(_gev(Scene.MAIN_MENU), main_menu)
	register_scene(_gev(Scene.SCENES), scenes_scene)
	connect_signal(SignalBus.change_scene, change_scene)
	change_to_main_menu()

static func _gev(scene_option:Scene):
	return Scene.keys()[scene_option]

static func change_to_main_menu():
	SignalBus.change_scene.emit(MainSM._gev(Scene.MAIN_MENU))

static func change_to_scenes_scene():
	SignalBus.change_scene.emit(MainSM._gev(Scene.SCENES))
