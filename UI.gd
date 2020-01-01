extends CanvasLayer

func set_roids(count):
	$VBoxContainer/Roids.text = "Roids: " + str(count)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Need to figure out how to query this.. :)
	$VBoxContainer/GPU.text = "OpenGL ES 3.0 Renderer: GeForce GTX 1060/PCIe/SSE2"
	
	# We're turning v-sync off purely to see our performance impact.
	# Don't do this for a real game!
	OS.vsync_enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var fps = Engine.get_frames_per_second()
	$VBoxContainer/FPS.text = "FPS: " + str(fps)
