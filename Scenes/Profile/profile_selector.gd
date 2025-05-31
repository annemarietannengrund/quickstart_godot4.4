class_name ProfileSelector extends BasicControl
enum PROFILE_ACTION { CHANGE_PROFILE, CHANGED_PROFILE }
@export var profile_picker_scene: PackedScene
@onready var profile_pickers: HBoxContainer = %ProfilePickers
func _ready():
	#connection_map = []
	connect_signals()
	# or
	#connect_signal()
	connect_signal(SignalBus.profile, handle_profile_actions)
	for i in range(3):
		var slot = profile_picker_scene.instantiate()
		slot.profile_id = i
		profile_pickers.add_child(slot)
	
func handle_profile_actions(option, value):
	match PROFILE_ACTION[PROFILE_ACTION.find_key(option)]:
		PROFILE_ACTION.CHANGE_PROFILE:
			App.config.active_profile_id = value
			SignalBus.saverloader.emit(SaverLoader.Action.SAVE_SETTINGS)
			SignalBus.saverloader.emit(SaverLoader.Action.LOAD_PROFILE)
			SignalBus.changed_profile.emit()

func _process(_delta):
	pass
