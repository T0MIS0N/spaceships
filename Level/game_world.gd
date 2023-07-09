extends Node3D

var laser = preload("res://Spaceship/laser.tscn")
var spaceship = preload("res://Spaceship/spaceship.tscn")
var asteroid = preload("res://Hazards/asteroid.tscn")
var bomb = preload("res://Hazards/bomb.tscn")
var spawn_on_left = true
var mouse_position : Vector3
var score = 0

@onready var top_left_post = $TopLeftPost
@onready var bottom_right_post = $BottomRightPost
@onready var camera = $Camera3D
@onready var projectiles = $Projectiles
@onready var spaceships = $Spaceships
@onready var hazards = $Hazards
@onready var left_spawner = $SpawnerLeft
@onready var right_spawner = $SpawnerRight
@onready var asteroid_timer = $AsteroidTimer
@onready var ship_timer = $ShipTimer
@onready var bombs = $Bombs


func _ready():
	spawn_space_ship()
	add_asteroid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	keep_within_boundaries(spaceships)
	keep_within_boundaries(hazards)
	set_score()


func keep_within_boundaries(collection):
	for ship in collection.get_children():
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
		mouse_position = camera.project_position(event.position,camera.position.y)
	if Input.is_action_just_pressed("kaboom"):
		var new_bomb = bomb.instantiate()
		new_bomb.global_position = mouse_position
		bombs.add_child(new_bomb)
	if Input.is_action_just_pressed("ui_accept"):
		$GameUI/TutorialPanel.visible = false


func spawn_projectile(direction, ship_position):
	var new_laser = laser.instantiate()
	new_laser.position = ship_position
	new_laser.direction = direction
	projectiles.add_child(new_laser)


func add_asteroid():
	var new_asteroid = asteroid.instantiate()
	if spawn_on_left:
		new_asteroid.global_position = left_spawner.global_position
		new_asteroid.direction = Vector3(randf_range(0,5),0,randf_range(-5,5)).normalized()
	else:
		new_asteroid.global_position = right_spawner.global_position
		new_asteroid.direction = Vector3(randf_range(-5,0),0,randf_range(-5,5)).normalized()
	hazards.add_child(new_asteroid)
	asteroid_timer.start()


func spawn_space_ship():
	var new_spaceship = spaceship.instantiate()
	new_spaceship.fire_projectile.connect(spawn_projectile)
	new_spaceship.death.connect(player_scored)
	spaceships.add_child(new_spaceship)


func player_scored():
	ship_timer.start()
	score += 1000
	kill_asteroids()


func kill_asteroids():
	for hazard in hazards.get_children():
		hazard.destroy_self()


func set_score():
	$GameUI/ScoreLabel.text = str("Score : ",score)


func _on_timer_timeout():
	add_asteroid()


func _on_ship_timer_timeout():
	spawn_space_ship()
