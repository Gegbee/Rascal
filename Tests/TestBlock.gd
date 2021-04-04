tool
extends MeshInstance


func _physics_process(delta: float) -> void:
	var water_height = get_node("../Water").get_water_height(self.global_transform.origin)
	translation.y = water_height
