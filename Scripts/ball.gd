class_name Ball
extends RigidBody2D

var initial_velocity := 300.0
var bounce_velocity := 300.0
var max_veloctity := 800.0
@export var loser_padel : Padel

func _ready():
	apply_central_force((loser_padel.position - position).normalized() * initial_velocity)


func _on_body_entered(body):
	if body is Padel:
		print("bounce!")
		#if linear_velocity.length() < max_veloctity:
		var direction := linear_velocity.normalized() + Vector2(0, randi_range(-1, 1))
		apply_central_force(direction * bounce_velocity)
