class_name SceneManagerBase extends BasicControl  

var registered_scenes: Dictionary = {}
@export var content_node: Control  

func register_scene(scene_code:String, scene: PackedScene):
	registered_scenes[scene_code] = scene
	
func change_scene(scene_code: String):  
	if scene_code not in registered_scenes.keys():
		return
	var pscene = registered_scenes.get(scene_code)  
	if not pscene:
		print("No valid scene found for scene ", scene_code)
		return
	NodeHelper.remove_children(content_node)  
	content_node.add_child(pscene.instantiate())
