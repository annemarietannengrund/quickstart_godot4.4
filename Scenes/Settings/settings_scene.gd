class_name SettingsSM extends SceneManagerBase


@onready var settings_general_button: Button = %GENERAL
@onready var settings_developer_button: Button = %DEVELOPER
@onready var back: Button = %BACK

@onready var settings_general_section: Control = %Settings_General
@onready var language_option_button: OptionButton = %LanguageOptionButton
@onready var settings_developer_section: Control = %Settings_Developer

enum Sections { GENERAL, DEVELOPER }
var sections :Array = []

func _ready():
	_setup_fields()
	connect_signal(back.pressed, MainSM.change_to_main_menu)
	connect_signal(settings_general_button.pressed, _menu_button_pressed.bind(settings_general_section))
	connect_signal(settings_developer_button.pressed, _menu_button_pressed.bind(settings_developer_section))


func _setup_fields():
	_setup_language_settings()

# Hides all child nodes of the content node
func _hide_contents():
	NodeHelper.hide_children(content_node)

# method for handling the main menu buttons in the settiongs scene
func _menu_button_pressed(element: Control):
	_hide_contents()
	element.show()
	
func _setup_language_settings():
	# Clear optionsbutton content
	language_option_button.clear()
	# add options
	for language_option in Globals.Language.keys():
		var index = Globals.Language[language_option]
		language_option_button.add_item(
			tr(language_option) + ' (' + Globals.language_map[index] + ')', 
			index
		)
		# make current value the preselected
		if App.config.active_language == index:
			language_option_button.selected = index
	# connect selected event to callback
	connect_signal(language_option_button.item_selected, _language_option_selected)

func _language_option_selected(selected_val: int):
	# update the config with the selected option
	App.config.active_language = Globals.Language[Globals.Language.find_key(selected_val)]
	# signal for a save of the settings file
	SignalBus.saverloader.emit(SaverLoader.Action.SAVE_SETTINGS as SaverLoader.Action)
	# set the translation server to the new language code
	TranslationServer.set_locale(Globals.language_map[App.config.active_language])
