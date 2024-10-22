extends Area2D
@onready var door: Area2D = $"../Text/Door"

func _on_body_entered(body: Node2D) -> void:
	Global.flags_collected = true
	queue_free() # Replace with function body.
