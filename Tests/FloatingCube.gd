extends RigidBody


var water_level : float = 0.0
export var bounce_level : float = 2000.0
export var calculate_bounce : bool = false
export (Array, NodePath) var vertex_positions = []
var vertices := []

func _ready() -> void:
	for vertex in vertex_positions:
		vertex_positions.erase(vertex)
		vertices.append(get_node(vertex))
	if calculate_bounce:
		bounce_level = mass * 4000.0
		
func _physics_process(delta: float) -> void:
	for vertex in vertices:
		var water_height = get_node("../Water").get_water_height(vertex.global_transform.origin)
		if vertex.global_transform.origin.y < water_height:
			add_force(Vector3(0, bounce_level * delta * (water_height - vertex.global_transform.origin.y), 0)
			, vertex.translation)
	
