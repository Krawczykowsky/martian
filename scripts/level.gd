extends Node2D

@export var next_level: PackedScene
@export var is_final_level: bool = false

@onready var player = $Player
@onready var start_positions = $StartingPoint
@onready var exit = $Exit
@onready var deadzone = $Deadzone
@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer

var timer_node = null
var level_time = 5
var time_left

var win = false

func _ready():
	player.global_position = start_positions.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
	exit.body_entered.connect(_on_exit_body_entered)
	deadzone.body_entered.connect(_on_area_2d_body_entered)
	
	time_left = level_time
	print("timelvl")
	print(time_left)
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level timer" 
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_timerout)
	add_child(timer_node)
	timer_node.start()

func _on_timerout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)
			

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	reset_player()


func _on_trap_touched_player():
	reset_player()

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start_positions.get_spawn_pos()

func _on_exit_body_entered(body):
	if body is Player:
		print("enter")
		print(next_level)
		if is_final_level || (next_level!=null):
			print("enter2")
			exit.animate()
			player.is_active = false
			win=true
			await get_tree().create_timer(1.5).timeout
			if is_final_level:
				ui_layer.show_win_screen(true)
			else:
				get_tree().change_scene_to_packed(next_level)
				
