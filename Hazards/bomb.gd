extends Node3D

@onready var boom = $AudioStreamPlayer
@onready var mesh = $MeshInstance3D
@onready var area = $Area3D
@onready var collision = $Area3D/CollisionShape3D


func _ready():
	kaboom()


func kaboom():
	mesh.visible = true
	boom.play()
	await boom.finished
	collision.disabled = true
	queue_free()


func push_asteroids():
	var asteroids = area.get_overlapping_areas()
	for asteroid in asteroids:
		var new_direction = global_position.direction_to(asteroid.global_position)
		asteroid.get_parent_node_3d().direction = new_direction
		asteroid.get_parent_node_3d().set_new_rotation()


func _on_area_3d_area_entered(area):
	push_asteroids()
