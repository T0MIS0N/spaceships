extends Node3D

@onready var top_left_post = $TopLeftPost
@onready var bottom_right_post = $BottomRightPost
@onready var spaceship = $Spaceship
@onready var camera = $Camera3D
@onready var obstacle = $Obstacle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	keep_within_boundaries()


func keep_within_boundaries():
	if spaceship.position.x < top_left_post.position.x:
		spaceship.position.x = bottom_right_post.position.x - 1
	
	if spaceship.position.x > bottom_right_post.position.x:
		spaceship.position.x = top_left_post.position.x + 1
	
	if spaceship.position.z < top_left_post.position.z:
		spaceship.position.z = bottom_right_post.position.z - 1
		
	if spaceship.position.z > bottom_right_post.position.z:
		spaceship.position.z = top_left_post.position.z + 1


func _input(event):
	if event is InputEventMouse:
		var pos3d = camera.project_position(event.position,camera.position.y)
		obstacle.position = pos3d
