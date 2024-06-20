extends Node2D

const BALL = preload("res://Scenes/ball.tscn")
@onready var pause_menu = $Camera2D/CanvasLayer/PauseMenu
@onready var score = $Camera2D/CanvasLayer/Score
var paused := false
var right_score := 0
var left_score := 0

func _ready():
	get_viewport().size = DisplayServer.screen_get_size() / 1.5
	$RightGoal.goal_scored.connect(on_right_goal_scored)
	$LeftGoal.goal_scored.connect(on_left_goal_scored)
	pause_menu.get_node("Panel/MarginContainer/VBoxContainer/Resume").pressed.connect(resumed)
	pause_menu.get_node("Panel/MarginContainer/VBoxContainer/Quit").pressed.connect(quited)
	pause_menu.get_node("Panel/MarginContainer/VBoxContainer/MainMenu").pressed.connect(back_to_main_menu)
	
func on_right_goal_scored():
	print("Left Scored!")
	left_score += 1
	update_score_labels()
	var ball := BALL.instantiate()
	ball.loser_padel = $Padels/RightPadel
	ball.position = Vector2.ZERO
	add_child(ball)

func on_left_goal_scored():
	print("Right Scored!")
	right_score += 1
	update_score_labels()
	var ball := BALL.instantiate()
	ball.loser_padel = $Padels/LeftPadel
	ball.position = Vector2.ZERO
	add_child(ball)

func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause_menu()

func toggle_pause_menu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func resumed():
	toggle_pause_menu()

func quited():
	toggle_pause_menu()
	get_tree().quit()

func back_to_main_menu():
	toggle_pause_menu()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func update_score_labels():
	score.get_node("BoxContainer/LeftScore").text = str(left_score)
	score.get_node("BoxContainer/RightScore").text = str(right_score)
