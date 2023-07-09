extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var acceleration = 0.1
@export var friction = 0.01
@export var target : Node3D

@onready var target_area = $TargetArea


func _physics_process(delta):
	if target == null:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)
		move_and_slide()
		return
	
	var direction = -(position.direction_to(target.position).normalized())
	if direction:
		velocity.x = move_toward(direction.x * SPEED, SPEED, acceleration) 
		velocity.z = move_toward(direction.z * SPEED, SPEED, acceleration)
	
	move_and_slide()


func _on_target_area_area_entered(area):
	change_target()


func _on_target_area_area_exited(area):
	change_target()


func change_target():
	var area_collection = target_area.get_overlapping_areas()
	if area_collection.size() < 1:
		target = null
		return
	var new_target = area_collection[0].get_parent_node_3d()
	for overlap_area in area_collection:
		if overlap_area.position.distance_to(position) < new_target.position.distance_to(position):
			new_target = overlap_area.get_parent_node_3d()
	target = new_target
