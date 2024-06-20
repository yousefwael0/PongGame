class_name Goal
extends Area2D

signal goal_scored

func _on_body_entered(body):
	if body is Ball:
		emit_signal("goal_scored")
		body.queue_free()
