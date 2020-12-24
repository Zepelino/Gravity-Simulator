extends Node

export var mouse_sensitive: float = 0.005

var focused: int = 0
onready var focused_body: RigidBody = $System/Earth

var cam_pos: float
func _process(delta):
	"""for i in $System.bodies:
		center += i.translation
	center /= $System.bodies.size()"""
	$CameraGimbal.translation = $CameraGimbal.translation.linear_interpolate(focused_body.translation, delta*3)

func _unhandled_input(event):
	if event is InputEventMouseMotion && Input.is_action_pressed("Mouse_move"):
		$CameraGimbal.rotate_object_local(Vector3.DOWN, event.relative.x * mouse_sensitive)
		$CameraGimbal/InnerGimbal.rotate_object_local(Vector3.RIGHT, event.relative.y * mouse_sensitive)
		$CameraGimbal/InnerGimbal.rotation.x = clamp($CameraGimbal/InnerGimbal.rotation.x, -PI/2, PI/2)
	if Input.is_action_pressed("Zoom_in"):
		cam_pos -= 1
	elif Input.is_action_pressed("Zoom_out"):
		cam_pos += 1
	cam_pos = clamp(cam_pos, 5, 200)
	$CameraGimbal/InnerGimbal/Camera.translation.z = cam_pos
	
	if Input.is_action_just_released("ui_accept"):
		focused += 1
		if focused > $System.get_child_count() - 1:
			focused = 0
		focused_body = $System.get_child(focused)
		
		$CanvasLayer/RichTextLabel.bbcode_text = "[right]Focused: [color=#%s]%s[/color][/right]" \
		%[focused_body.color.to_html(false), focused_body.name]
	
	if Input.is_action_just_pressed("ui_up"):
		Engine.time_scale += 1
	elif Input.is_action_just_pressed("ui_down"):
		Engine.time_scale -= 1
