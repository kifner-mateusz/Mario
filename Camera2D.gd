extends Camera2D

onready var players= get_parent().get_node("Players")

func _process(delta):
	var center_point = lerp(players.get_child(0).position,players.get_child(1).position,0.5)
	var player_dist = players.get_child(0).position.distance_to(players.get_child(1).position)
	var camera_scale = lerp(1,10,player_dist/10000)
	position = center_point
	zoom = Vector2(camera_scale,camera_scale)
