extends Spatial

export var move_speed = 20.0
export var rotation_speed = 0.005
export var rotation_smoothing = 20.0

var target_x_rotation = 0.0
var target_y_rotation = 0.0
var x_rotation = 0.0
var y_rotation = 0.0

# React to actions
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		target_x_rotation = clamp(target_x_rotation - event.relative.y * rotation_speed, -PI * 0.5, PI * 0.5);
		target_y_rotation -= event.relative.x * rotation_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var d = clamp(delta * rotation_smoothing, 0.0, 1.0)
	# lerp our rotations to get a bit of a smoother camera at the expense of a slight lag
	y_rotation = lerp(y_rotation, target_y_rotation, d)
	rotation.y = y_rotation
	x_rotation = lerp(x_rotation, target_x_rotation, d)
	$Camera.rotation.x = x_rotation
	
	# and handle movement...
	var move = Vector3()
	if Input.is_action_pressed("ui_up"):
		move.z = -1.0
	elif Input.is_action_pressed("ui_down"):
		move.z = 1.0
	
	if Input.is_action_pressed("ui_left"):
		move.x = -1.0
	elif Input.is_action_pressed("ui_right"):
		move.x = 1.0
	
	var t = global_transform
	var ct = $Camera.global_transform
	t.origin = t.origin + (ct.basis.z * move.z * move_speed * delta)
	t.origin = t.origin + (ct.basis.x * move.x * move_speed * delta)

	global_transform = t
