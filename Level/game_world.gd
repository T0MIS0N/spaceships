extends Node3D

var laser = preload("res://Spaceship/laser.tscn")
var spaceship = preload("res://Spaceship/spaceship.tscn")

@onready var top_left_post = $TopLeftPost
@onready var bottom_right_post = $BottomRightPost
@onready var camera = $Camera3D
@onready var obstacle = $Obstacle
@onready var projectiles = $Projectiles
@onready var spaceships = $Spaceships


func _ready():
	var new_spaceship = spaceship.instantiate()
	new_spaceship.fire_projectile.connect(spawn_projectile)
	spaceships.add_child(new_spaceship)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	keep_within_boundaries()


func keep_within_boundaries():
	for ship in spaceships.get_children():
		if ship.position.x < top_left_post.position.x:
			ship.position.x = bottom_right_post.position.x - 1
		
		elif ship.position.x > bottom_right_post.position.x:
			ship.position.x = top_left_post.position.x + 1
		
		elif ship.position.z < top_left_post.position.z:
			ship.position.z = bottom_right_post.position.z - 1
			
		elif ship.position.z > bottom_right_post.position.z:
			ship.position.z = top_left_post.position.z + 1


func _input(event):
	if event is InputEventMouse:
		var pos3d = camera.project_position(event.position,camera.position.y)
		obstacle.position = pos3d


func spawn_projectile(direction, ship_position):
	var new_laser = laser.instantiate()
	new_laser.position = ship_position
	new_laser.direction = direction
	projectiles.add_child(new_laser)
