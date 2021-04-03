extends StaticBody


var speed : float = 0.0

onready var boat = get_parent()

func _process(delta: float) -> void:
	boat.add_central_force(Vector3(speed, 0, 0))

func set_speed(amt : float):
	speed = amt
	
	
