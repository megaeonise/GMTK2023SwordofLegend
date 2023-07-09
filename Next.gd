extends Node2D
var current = ''

func _ready():
	var current_scene = get_tree().get_current_scene().get_name()
	current = current_scene


func _on_body_entered(body):
	VariableStore.upgrade_points +=3
	match current:
		'Tutorial_Plr':
			get_tree().change_scene_to_file('res://Tutorial_Swd.tscn')

