extends Node2D

@onready var player = $Player
@onready var start_positions = $StartPositions

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	body.velocity = Vector2.ZERO
	body.global_position = start_positions.global_position
