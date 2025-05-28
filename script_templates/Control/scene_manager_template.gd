class_name Template_SMT extends SceneManagerBase

enum Scene { SOME, SCENES }
@export var some_scene: PackedScene
@export var scenes_scene: PackedScene

func _ready():
	register_scene(_gev(Scene.SOME), some_scene)
	register_scene(_gev(Scene.SCENES), scenes_scene)
	connect_signal(SignalBus.change_scene, change_scene)

static func _gev(scene_option:Scene):
	return Scene.keys()[scene_option]

static func change_to_some_scene():
	SignalBus.change_scene.emit(Template_SMT._gev(Scene.SOME))

static func change_to_scenes_scene():
	SignalBus.change_scene.emit(Template_SMT._gev(Scene.SCENES))
