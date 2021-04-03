extends Spatial


var turn_speed : float = 2.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("turnRight"):
		rotate_y(delta * turn_speed)
	if Input.is_action_pressed("turnLeft"):
		rotate_y(delta * -turn_speed)
#	$Camera.global_transform.origin = lerp($Camera.global_transform.origin, get_parent().global_transform.origin, 0.1)
#	$Camera.translation = Vector3(10, 16, 0)
