extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const acceleration = 0.1
const friction = 0.01

@export var target : Node3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var target_area = $TargetArea

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		pass
#		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if target == null:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)
		move_and_slide()
		return
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = -(position.direction_to(target.position).normalized())
	if direction:
		velocity.x = move_toward(direction.x * SPEED, SPEED, acceleration) 
		velocity.z = move_toward(direction.z * SPEED, SPEED, acceleration) 
#	else:
#		velocity.x = move_toward(velocity.x, 0, friction)
#		velocity.z = move_toward(velocity.z, 0, friction)

	move_and_slide()


func _on_target_area_area_entered(area):
	var object = area.get_parent_node_3d()
	target = object


func _on_target_area_area_exited(area):
	target = null
