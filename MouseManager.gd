extends Spatial

func find_collider():
	var intersect_result = find_pos(0)
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(get_viewport().get_camera().global_transform.origin, intersect_result, [self])
	return result

func find_pos(plane_height : float) -> Vector3:
	var travel_plane = Plane(Vector3(0, 1, 0), plane_height)
	var camera: Camera = get_viewport().get_camera()
	var intersect_result = travel_plane.intersects_ray(camera.project_ray_origin(get_viewport().get_mouse_position()), 
	camera.project_ray_normal(get_viewport().get_mouse_position()))
	return intersect_result
