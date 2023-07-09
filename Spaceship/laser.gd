extends CharacterBody3D

@export var speed = 7.0
@export var direction : Vector3


func _physics_process(delta):
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()


func _on_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	queue_free()
