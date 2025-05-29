class_name SettingsSM extends SceneManagerBase

enum Scene { SETTINGS_GENERAL, SCENES }
@export var some_scene: PackedScene
@export var scenes_scene: PackedScene

@onready var settings_general: Button = %SETTINGS_GENERAL
@onready var back: Button = %BACK

func _ready():
	register_scene(_gev(Scene.SETTINGS_GENERAL), some_scene)
	connect_signal(SignalBus.change_scene, change_scene)
	connect_signal(back.pressed, MainSM.change_to_main_menu)

static func _gev(scene_option:Scene):
	return Scene.keys()[scene_option]

static func change_to_some_scene():
	SignalBus.change_scene.emit(SettingsSM._gev(Scene.SETTINGS_GENERAL))
