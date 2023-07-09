extends MenuButton

var empty = 'Upgrade Points: %s\nSword Length: %s\nRange: %s\nGripStrength: %s'

func _ready():
	$Upgrades.add_item('Sword Length', 0)
	$Upgrades.add_item('Range', 1)
	$Upgrades.add_item('Grip Strength', 2)


func _on_upgrades_id_pressed(id):
	if VariableStore.upgrade_points>0:
		match id:
			0:
				VariableStore.length_upgrade += 1
			1:
				VariableStore.range_upgrade += 1
			2:
				VariableStore.grip_upgrade +=1
		VariableStore.upgrade_points-=1
		

func _process(delta):
	$Status.set_text(empty % [VariableStore.upgrade_points,VariableStore.length_upgrade,VariableStore.range_upgrade,VariableStore.grip_upgrade])




func _on_toggled(button_pressed):
	$Upgrades.popup()
	if $Status.visible == false:
		$Status.set_visible(true)
	else:
		$Status.set_visible(false)
