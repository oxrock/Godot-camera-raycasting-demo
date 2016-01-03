extends KinematicBody
# This is a demo showcasing how to make camera obstructions temporarily transparent
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
	obstruction = get_parent().get_node("StaticBody/TestCube")
	
func _fixed_process(delta): 
	if Input.is_key_pressed(KEY_UP): #player movement forward
		pos =get_transform()
		move(-pos.basis[2]*.25)
	if Input.is_key_pressed(KEY_DOWN): #player movement backward
		pos =get_transform()
		move(pos.basis[2]*.25)
	if Input.is_key_pressed(KEY_LEFT): #player movement rotate counter clockwise
		rotate_y( deg2rad( -125 * delta))
	if Input.is_key_pressed(KEY_RIGHT): #player movement rotate clockwise
		rotate_y( deg2rad( 125 * delta))
	

	if ray.is_enabled() and ray.is_colliding(): # only if ray is enabled and actually hitting something,
		obstruction = ray.get_collider().get_node("TestCube") #targets the visible node of the object ray has collided with
		status = "Hidden" #sets label to hidden so we can see the status on screen
		obstruction.hide()
		lab.set_text(status) #updates the label's text
		
	else: # if ray has collided with nothing (or ray is disabled)
		obstruction.show() #show the object the we hid before
		status = "Shown"
		lab.set_text(status) #update label with new status
