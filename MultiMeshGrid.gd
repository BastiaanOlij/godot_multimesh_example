extends Spatial

var multi_mesh_resource = preload("res://MultiMesh_Grid_item.tscn")

func add_roids():
	var count = 0
	for mm in $Grid.get_children():
		count += mm.add_roids()
	
	$UI.set_roids(count)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		add_roids()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create our multimesh grid
	var pos = Vector3(-550.0, -550.0, -550.0)
	for z in range(0, 10):
		pos.y = -550.0
		for y in range(0, 10):
			pos.x = -550.0
			for x in range(0, 10):
				var mm = multi_mesh_resource.instance()
				$Grid.add_child(mm)
				
				var t = Transform()
				t.origin = pos
				mm.global_transform = t
				
				pos.x += 100.0
			
			pos.y += 100.0
		
		pos.z += 100.0
	
	add_roids()
