extends KinematicBody
# This is a demo showcasing how to make camera obstructions temporarily transparent
# you SHOULD be able to collide with the boxes, for some reason it is bugged currently. Change staticbodies to rigidbodies to enjoy smacking them around.
# use keyboard arrow keys to move around scene
var ray = null
var obstruction = null
var obstructions = []

func _ready():
	ray = get_node("Camera/RayCast")
	set_process(true)
	
func _process(delta):
	if Input.is_key_pressed(KEY_UP):
		self.translate(Vector3(0,0,-10 * delta))
	if Input.is_key_pressed(KEY_DOWN):
		self.translate(Vector3(0,0,10 * delta))
	if Input.is_key_pressed(KEY_LEFT):
		self.rotate_y( deg2rad( -75 * delta))
	if Input.is_key_pressed(KEY_RIGHT):
		self.rotate_y( deg2rad( 75 * delta))
	

	if ray.is_enabled() and ray.is_colliding(): #For some reason referencing "ray" causes error
		obstruction = get_node("Camera/RayCast").get_collider()
		obstruction.hide()
		obstructions.append(obstruction)
	else:
		for i in obstructions:
			i.show()
		obstructions = []
	
	