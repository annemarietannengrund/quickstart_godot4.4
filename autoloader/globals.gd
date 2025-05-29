extends Node

const SAVEDATA_PATH = "res://savedata/"  
const APP_PROFILE_FILE_PATH = SAVEDATA_PATH + "slot_%s.tres"  
const APP_SAVEGAME_FILE_PATH = SAVEDATA_PATH + "slot_%s_savegame.tres"  
const APP_CONFIG_FILE_PATH = SAVEDATA_PATH + "app_config.tres"  

enum Language { ENGLISH, GERMAN }  
  
var language_map = {  
	Language.ENGLISH: 'en',  
	Language.GERMAN: 'de',  
}

static func get_profile_path_for(profile_id:int)->String:
	return APP_PROFILE_FILE_PATH % [profile_id]
