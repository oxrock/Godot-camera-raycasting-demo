extends KinematicBody
# This is a demo showcasing how to make camera obstructions temporarily transparent
# you SHOULD be able to collide with the boxes, for some reason it is bugged currently. Change staticbodies to rigidbodies to enjoy smacking them around.
# use keyboard arrow keys to move around scene
var ray = null
var obstruction = null
var lab = null
var status = null
var pos = null

func _ready():
	ray = get_node("Camera/RayCast")
	lab = get_parent().get_node("Label")
	set_fixed_process(true)
	pos = get_transform()
	obstruction = get_parent().get_node("StaticBody")
	
func _fixed_process(delta):
	if Input.is_key_pressed(KEY_UP):
		pos =get_transform()
		move(-pos.basis[2]*.25)
	if Input.is_key_pressed(KEY_DOWN):
		pos =get_transform()
		move(pos.basis[2]*.25)
	if Input.is_key_pressed(KEY_LEFT):
		rotate_y( deg2rad( -75 * delta))
	if Input.is_key_pressed(KEY_RIGHT):
		rotate_y( deg2rad( 75 * delta))
	

	if ray.is_enabled() and ray.is_colliding(): 
		obstruction = ray.get_collider()
		status = "Hidden"
		obstruction.hide()
		lab.set_text(status)
		
	else:
		obstruction.show()
		status = "Shown"
		lab.set_text(status)
