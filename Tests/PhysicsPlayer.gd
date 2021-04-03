extends RigidBody

onready var camera : Spatial = $CameraBase
export var movement_speed : float = 500.0
var movement := Vector3()
export var jump_force : float = 12.0
export var water_level : float = 0.0
export var bounce_level : float = 2000.0

func _physics_process(delta: float) -> void:
	get_node("../Water").global_transform.origin.x = global_transform.origin.x
	get_node("../Water").global_transform.origin.z = global_transform.origin.z
	get_node("../Water").rotation = $CameraBase.rotation
	
	movement = Vector3()
	if Input.is_action_pressed("up"):
		movement += Vector3(-1, 0, 0).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("down"):
		movement += Vector3(1, 0, 0).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("right"):
		movement += Vector3(0, 0, -1).rotated(Vector3(0, 1, 0), camera.rotation.y)
	if Input.is_action_pressed("left"):
		movement += Vector3(0, 0, 1).rotated(Vector3(0, 1, 0), camera.rotation.y)
	movement = (movement).normalized() * movement_speed * delta
	var water_level = get_node("../Water").get_water_height(self.global_transform.origin)
	if Input.is_action_just_pressed("jump"):
		if (global_transform.origin.y < water_level or len(get_colliding_bodies()) > 0):
			apply_central_impulse(Vector3(0, jump_force, 0))
	if global_transform.origin.y < water_level:
		add_force(Vector3(0, bounce_level * delta * (water_level-global_transform.origin.y), 0), Vector3())
		
func _integrate_forces(state: PhysicsDirectBodyState) -> void:
	linear_velocity.x = movement.x
	linear_velocity.z = movement.z
