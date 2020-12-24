extends Node


var bodies: Array

func _ready():
	Engine.time_scale = 1
	for i in get_children():
		bodies.append(i)
	


# F = m1 * m2 / d^2
func _physics_process(delta):
	
	for i in bodies:
		for other in bodies:
			
			if other == i:
				continue
			
			var dir = (other.translation - i.translation).normalized()
			var abslt = i.mass * other.mass / pow(i.translation.distance_to(other.translation), 2)
			
			var force = dir * abslt
			
			i.add_force(force, i.translation)
