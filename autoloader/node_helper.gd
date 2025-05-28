extends Control

func hide_children(node:Node)->void:
	for child in node.get_children():
		child.hide()

func show_children(node:Node)->void:
	for child in node.get_children():
		child.hide()
		
func remove_children(node:Node)->void:
	for child in node.get_children():
		node.remove_child(child)
		# SignalBus.disconnect_user_signals(child)
		child.queue_free()
