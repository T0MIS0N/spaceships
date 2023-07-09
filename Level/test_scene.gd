extends Node3D

@onready var top_left_post = $TopLeftPost
@onready var bottom_right_post = $BottomRightPost
@onready var spaceship = $Spaceship


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	keep_within_boundaries()


func keep_within_boundaries():
	if spaceship.position.x < top_left_post.position.x:
		print("LEFT")
		spaceship.position.x = bottom_right_post.position.x - 1
	
	if spaceship.position.x > bottom_right_post.position.x:
		print("RIGHT")
		spaceship.position.x = top_left_post.position.x + 1
	
	if spaceship.position.z < top_left_post.position.z:
		print("TOP")
		spaceship.position.z = bottom_right_post.position.z - 1
		
	if spaceship.position.z > bottom_right_post.position.z:
		print("BOTTOM")
		spaceship.position.z = top_left_post.position.z + 1


func _input(event):
	if event is InputEventMouse:
		var pos3d = $Camera3D.project_position(event.position,$Camera3D.position.y)
		$Obstacle.position = pos3d
		if $Obstacle.position.y > 0:
			print($Obstacle.position)
