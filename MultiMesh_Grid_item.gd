extends MultiMeshInstance

var start_roids = 1
var max_roids = 4000
var max_dist = 100.0

onready var mm = multimesh

func add_roids():
	if mm.visible_instance_count == max_roids:
		return 0
	
	var needed_roids = clamp(mm.visible_instance_count * 2, start_roids, max_roids)
	
	for i in range (mm.visible_instance_count, needed_roids):
		var t = Transform().scaled(Vector3(0.002, 0.002, 0.002))
		
		t.origin = Vector3(randf() * max_dist, randf() * max_dist, randf() * max_dist) - Vector3(0.5 * max_dist, 0.5 * max_dist, 0.5 * max_dist)
		
		mm.set_instance_transform(i, t)
	
	mm.visible_instance_count = needed_roids
	
	return mm.visible_instance_count

# Called when the node enters the scene tree for the first time.
func _ready():
	mm.instance_count = max_roids

