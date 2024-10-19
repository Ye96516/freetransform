extends Window

@onready var icon: Sprite2D = $Icon

var direction:Vector2i


func _ready() -> void:
	#get_viewport().always_on_top = true
	pass

func _process(delta: float) -> void:
	direction=Vector2(Input.get_action_strength("d")-Input.get_action_strength("a"),
							Input.get_action_strength("s")-Input.get_action_strength("w"))
	position+=Vector2i(300*delta*direction)
	pass
	
