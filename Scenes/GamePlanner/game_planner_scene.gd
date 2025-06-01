class_name GamePlannerSM extends SceneManagerBase


@onready var settings_general_button: Button = %GENERAL
@onready var settings_developer_button: Button = %DEVELOPER
@onready var back: Button = %BACK

@onready var settings_general_section: Control = %Settings_General
@onready var settings_developer_section: Control = %Settings_Developer

@onready var planet_type_option_button: OptionButton = %PLANET_TYPE
@onready var map_size_option_button: OptionButton = %MAP_SIZE
@export var game_planner: GamePlanner = GamePlanner.new()
@onready var player_name: LineEdit = %PLAYER_NAME
@onready var player_budget: OptionButton = %PLAYER_BUDGET
@onready var start_game: Button = %START_GAME

func _ready():
	connect_signal(back.pressed, MainSM.change_to_main_menu)
	connect_signal(settings_general_button.pressed, _menu_button_pressed.bind(settings_general_section))
	connect_signal(settings_developer_button.pressed, _menu_button_pressed.bind(settings_developer_section))
	connect_signal(start_game.pressed, SignalBus.new_game.emit.bind(game_planner))
	connect_signal(player_name.text_changed, _player_name_changed)

func _player_name_changed(new_text:String):
	game_planner.player_name = new_text.strip_edges()
	
# Hides all child nodes of the content node
func _hide_contents():
	NodeHelper.hide_children(content_node)

# method for handling the main menu buttons in the settiongs scene
func _menu_button_pressed(element: Control):
	_hide_contents()
	element.show()
