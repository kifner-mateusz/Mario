tool
extends RayCast2D

func _ready():
	add_user_signal("head_hit",[null])
	connect("head_hit",get_parent(),"_on_player_hit")

func _process(delta):
	if is_colliding():
		emit_signal("head_hit",get_collider())
