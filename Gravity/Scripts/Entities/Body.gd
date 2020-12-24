tool
extends RigidBody

var ready: bool

export(Color, RGB) var color = Color.red setget update_color, get_color

export(float, 0, 40, 0.01) var radius = 1 setget update_rad
export(float, 0, 80, 0.01) var height = 2 setget update_height

export(bool) var emission = false setget is_emitting
export(Color, RGB) var emission_color setget update_emission
export(float, 0, 16, 0.1) var emission_energy setget update_emission_energy

func update_emission_energy(new_value):
	emission_energy = new_value
	if ready && emission:
		$Mesh.get("material/0").set("emission_energy", emission_energy)

func update_emission(new_value):
	emission_color = new_value
	if ready && emission:
		$Mesh.get("material/0").set("emission", emission_color)

func is_emitting(new_value):
	emission = new_value
	if ready:
		$Mesh.get("material/0").set("emission_enabled", emission)
		$Mesh.get("material/0").set("emission_energy", emission_energy)
		$Mesh.get("material/0").set("emission", emission_color)

func update_rad(new_rad):
	radius = new_rad
	if ready:
		$Mesh.mesh.set("radius", radius)
		$Mesh.mesh.set("height", radius *2)
		$CollisionShape.shape.set("radius", radius)

func update_height(new_value):
	height = new_value
	if ready:
		$Mesh.mesh.set("height", height)

func update_color(new_color):
	color = new_color
	if ready:
		$Mesh.get("material/0").set("albedo_color", new_color)
		$Trail.mesh.get("material").set("albedo_color", color)

func get_color():
	return color

func _ready():
	ready = true
	##### setting properties ######
	$Mesh.get("material/0").set("albedo_color", color)
	$Trail.mesh.get("material").set("albedo_color", color)
	
	$Mesh.get("material/0").set("emission_enabled", emission)
	$Mesh.get("material/0").set("emission_energy", emission_energy)
	$Mesh.get("material/0").set("emission", emission_color)

	$Mesh.mesh.set("radius", radius)
	$Mesh.mesh.set("height", height if height != 0 else radius *2)
	$CollisionShape.shape.set("radius", radius)
	###############################
