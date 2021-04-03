extends KinematicBody

onready var camera : Spatial = $CameraBase
export var movement_speed : float = 600.0
var movement := Vector3()
var velocity := Vector3()
export var gravity : float = 20.0
export var jump_force : float = 600.0
export var max_velocity : float = 800
export var water_level : float = 0.0
export var bounce_level : float = 20.0
var moveable : bool = true

func _physics_process(delta: float) -> void:
	
	#X, Z
	movement = Vector3()
	if Input.is_action_pressed("up"):
		movement += Vector3(-1, 0, 0).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("down"):
		movement += Vector3(1, 0, 0).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("right"):
		movement += Vector3(0, 0, -1).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("left"):
		movement += Vector3(0, 0, 1).rotated(Vector3(0, 1, 0), camera.rotation.y)
	movement = (movement).normalized() * movement_speed
	
	#Y
	if !is_on_floor():
		velocity.y += -gravity
		velocity.y -= velocity.y / 16
	else:
		movement.x += get_floor_velocity().x
		movement.z += get_floor_velocity().z

		velocity.y = 0
	if global_transform.origin.y < water_level:
		velocity.y += bounce_level
		velocity.y -= velocity.y / 8
	if (global_transform.origin.y < water_level or is_on_floor()):
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force * delta
	velocity.y = clamp(velocity.y, -max_velocity, max_velocity)
	
	#FINAL
	velocity.x = movement.x
	velocity.z = movement.z
	velocity *= delta
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)

	#MOUSE
	if Input.is_action_pressed("rightMouse"):
		var col = MouseManager.find_collider()
		if col.has("collider") and col.collider != null and col.collider.is_in_group("Motor"):
			col.collider.set_speed(0)
	if Input.is_action_pressed("leftMouse"):
		var col = MouseManager.find_collider()
		if col.has("collider") and col.collider != null and col.collider.is_in_group("Motor"):
			col.collider.set_speed(20)
