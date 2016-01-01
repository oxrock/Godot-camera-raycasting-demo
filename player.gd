extends KinematicBody
# This is a demo showcasing how to make camera obstructions temporarily transparent
# you SHOULD be able to collide with the boxes, for some reason it is bugged currently. Change staticbodies to rigidbodies to enjoy smacking them around.
# use keyboard arrow keys to move around scene
var ray = null
var obstruction = null
var obstructions = {}
var lab = null
var status = null
var timer = 0

func _ready():
	ray = get_node("Camera/RayCast")
	lab = get_parent().get_node("Label")
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
		if obstructions.has(str(obstruction.get_name())) == false:
			obstructions[str(obstruction.get_name())] = obstruction
			obstruction.hide()
		timer = 1.0
		status = "Hidden"
	else:
		timer -= delta
		if timer <= 0:
			for i in obstructions:
				obstructions[i].show()
			obstructions.clear()
			status = "Shown"
	lab.set_text(status)
	
	