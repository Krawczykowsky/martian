extends Control

@onready var time_label = $TimeLabel

func set_time_label(value):
	print(value)
	time_label.text = "TIME: " + str(value)
