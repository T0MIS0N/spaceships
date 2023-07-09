extends CharacterBody3D

@export var speed = 4.0
@export var direction : Vector3

var rotation_vector : Vector3

@onready var asteroid_sfx = $AudioStreamPlayer
@onready var collision_shape = $Hitbox/CollisionShape3D


func _ready():
	set_new_rotation()


func _physics_process(delta):
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	rotation_degrees.x = wrapf(rotation_degrees.x + rotation_vector.x,-180,180)
	rotation_degrees.y = wrapf(rotation_degrees.y + rotation_vector.y,-180,180)
	rotation_degrees.z = wrapf(rotation_degrees.z + rotation_vector.z,-180,180)
	
	move_and_slide()


func _on_hitbox_area_entered(area):
	destroy_self()


func destroy_self():
	collision_shape.set_deferred("disabled",true)
	visible = false
	asteroid_sfx.play()
	await asteroid_sfx.finished
	queue_free()


func set_new_rotation():
	rotation_vector = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1))
