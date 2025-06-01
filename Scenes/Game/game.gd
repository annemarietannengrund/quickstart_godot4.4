class_name GameSM extends SceneManagerBase

enum Scene { SOME, SCENES }
@export var some_scene: PackedScene
@export var scenes_scene: PackedScene
@export var game_planner: GamePlanner
@onready var player_name_label: Label = %PlayerNameLabel
@onready var quit_save: Button = %QUIT_SAVE
@onready var menu_container: VBoxContainer = %MenuContainer
@onready var game_timer: GameTimer = %GameTimer


func _ready():
	register_scene(_gev(Scene.SOME), some_scene)
	register_scene(_gev(Scene.SCENES), scenes_scene)
	connect_signal(SignalBus.change_scene, change_scene)
	connect_signal(quit_save.pressed, quit_n_save)
	update_content()
	
	
func update_content():
	if game_planner:
		player_name_label.text = game_planner.player_name
		
func quit_n_save():
	SignalBus.saverloader.emit(SaverLoader.Action.SAVE_GAME)
	MainSM.change_to_main_menu()

static func _gev(scene_option:Scene):
	return Scene.keys()[scene_option]

func on_load_game(savegame:Savegame):
	for data in savegame.data:
		if data is GamePlanner:
			game_planner = data
			continue
	update_content()

func on_save_game(savegame:Savegame):
	savegame.data.append(game_planner)
