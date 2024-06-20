class_name Padel
extends StaticBody2D


enum Player {Left_Padel, Right_Padel}
@export var controls : Player
@export var speed := 10.0
@export var top_border : StaticBody2D
@export var bottom_border : StaticBody2D

func _process(delta):
	match controls:
		Player.Left_Padel:
			if Input.is_action_pressed("W"):
				position.y -= speed
			elif Input.is_action_pressed("S"):
				position.y += speed
		Player.Right_Padel:
			if Input.is_action_pressed("Up"):
				position.y -= speed
			elif Input.is_action_pressed("Down"):
				position.y += speed
	position.y = clamp(position.y, top_border.position.y + $Sprite2D.texture.get_height()/2, bottom_border.position.y - $Sprite2D.texture.get_height()/2)
