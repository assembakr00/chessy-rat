extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "RatPlayer":
		body.collect_cheese()
		self.queue_free()
