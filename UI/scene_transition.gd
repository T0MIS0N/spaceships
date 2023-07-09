extends CanvasLayer

@onready var ship_anim = $ShipAnimPlayer
@onready var loading_anim = $LoadingAnimPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var thread = Thread.new()
	ship_anim.play("spin")


func change_scene(new_scene : String):
	loading_anim.play("dissolve")
	await loading_anim.animation_finished
	get_tree().change_scene_to_file(new_scene)
	loading_anim.play_backwards("dissolve")
