extends Sprite2D


func _process(delta: float) -> void:
	var direction=Vector2(Input.get_action_strength("d")-Input.get_action_strength("a"),
	Input.get_action_strength("s")-Input.get_action_strength("w"))
	position+=300*delta*direction
