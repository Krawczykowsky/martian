extends ParallaxBackground

@onready var sprite_2d = $ParallaxLayer/Sprite2D
@export var scroll_speed = 15
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

func _ready():
	sprite_2d.texture = bg_texture

func _process(delta):
	sprite_2d.region_rect.position += delta * Vector2(scroll_speed, 0)
	if sprite_2d.region_rect.position == Vector2(64,64):
		sprite_2d.region_rect.position = Vector2.ZERO
