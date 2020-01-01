extends Spatial

var start_roids = 1000
var max_roids = 1000000
var max_dist = 1000.0

var current_roids = 1

func add_roids():
	if current_roids == max_roids:
		return
	
	var needed_roids = clamp(current_roids * 2, start_roids, max_roids)
	
	for i in range(current_roids, needed_roids):
		# Create a new mesh instance
		var new_meshinstance = MeshInstance.new()
		new_meshinstance.mesh = $MeshInstance.mesh
		
		var t = Transform().scaled(Vector3(0.002, 0.002, 0.002))
		t.origin = Vector3(randf() * max_dist, randf() * max_dist, randf() * max_dist) - Vector3(0.5 * max_dist, 0.5 * max_dist, 0.5 * max_dist)
		
		add_child(new_meshinstance)
		new_meshinstance.global_transform = t
	
	current_roids = needed_roids
	$UI.set_roids(current_roids)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_roids()

# React to our spacebar
func _input(event):
	if event.is_action_pressed("ui_accept"):
		add_roids()
