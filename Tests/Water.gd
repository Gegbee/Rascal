extends MeshInstance

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	
func get_water_height(pos : Vector3) -> float:
	var height : float = 0.0;
	var wave_height = get_water_var("wave_height")
	var wave_length = get_water_var("wave_length")
	var time_factor = get_water_var("time_factor")
	height = wave_height * sin((pos.x + time / time_factor) * wave_length) + wave_height * sin((pos.z + time / time_factor) * wave_length)
	return height

func set_water_amplitude(amp : float):
	get("material/0").set_shader_param("wave_height", amp)

func set_water_time(time : float):
	get("material/0").set_shader_param("timer_factor", time)
	
func set_water_period(per : float):
	get("material/0").set_shader_param("wave_length", per)
	
func get_water_var(var_name: String):
	return get("material/0").get_shader_param(var_name) 
