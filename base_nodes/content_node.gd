class_name Content extends BasicControl  

# Flushing of childs can be toggled for usage in simpler setups
@export var flush_on_ready: bool = true
# ContentControl container is used as a reusable container within scenemanagers  
# to make selection of node type explicit  
func _ready():  
	if flush_on_ready: NodeHelper.remove_children(self)
