class_name Content extends BasicControl  
  
# ContentControl container is used as a reusable container within scenemanagers  
# to make selection of node type explicit  
func _ready():  
	NodeHelper.remove_children(self)
