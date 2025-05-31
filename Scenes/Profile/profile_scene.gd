class_name ProfileSM extends SceneManagerBase

@onready var back: Button = %BACK
@onready var current: Button = %CURRENT
@onready var change: Button = %CHANGE
@onready var profile_current: Control = %Profile_Current
@onready var profile_change: Control = %Profile_Change
@onready var total_ticks_value: Label = %TotalTicksValue
@onready var slot_name_value: Label = %SlotNameValue

func _ready():
	if App.user_profile is not ProfileData:
		App.user_profile = ProfileData.new()
	update_profile_data()
	connect_signal(back.pressed, MainSM.change_to_main_menu)
	connect_signal(current.pressed, _menu_button_pressed.bind(profile_current))
	connect_signal(change.pressed, _menu_button_pressed.bind(profile_change))
	connect_signal(SignalBus.changed_profile, update_profile_data)
	
func update_profile_data():
	total_ticks_value.text = str(App.user_profile.total_ticks)
	slot_name_value.text = str(App.user_profile.profile_id)

# Hides all child nodes of the content node
func _hide_contents():
	NodeHelper.hide_children(content_node)

# method for handling the main menu buttons in the settiongs scene
func _menu_button_pressed(element: Control):
	_hide_contents()
	element.show()
