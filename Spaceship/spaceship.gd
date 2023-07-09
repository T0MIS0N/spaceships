extends CharacterBody3D

signal fire_projectile(direction, position)

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var acceleration = 0.1
@export var friction = 0.04
@export var target : Node3D

var can_fire = true

@onready var target_area = $TargetArea
@onready var mesh = $spaceship
@onready var fireray = $spaceship/Fireray
@onready var timer = $Timer
@onready var laser_sfx = $LaserGunSFX


func _physics_process(delta):
	if fireray.is_colliding() and can_fire:
		var collide_point = fireray.get_collision_point()
		var collider_direction = global_position.direction_to(collide_point).normalized()
		spawn_projectile(collider_direction)
		can_fire = false
		timer.start()
	if target == null:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)
		move_and_slide()
		return
	var direction = -(position.direction_to(target.position).normalized())
	if direction:
		velocity.x = move_toward(direction.x * SPEED, SPEED, acceleration) 
		velocity.z = move_toward(direction.z * SPEED, SPEED, acceleration)
		mesh.rotation.y = Vector2(velocity.x, -velocity.z).angle() + deg_to_rad(90)
	
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


func spawn_projectile(direction):
#	print("FIRE PROJECTILE")
	emit_signal("fire_projectile", direction, global_position)
	laser_sfx.play()


func _on_timer_timeout():
	can_fire = true
