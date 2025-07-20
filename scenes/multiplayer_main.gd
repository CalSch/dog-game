extends Node2D

func _ready() -> void:
	$MultiPlayCore.player_connected.connect(
		func(player: MPPlayer):
			print("Player connected: ",player.player_id)
	)
	$MultiPlayCore.player_disconnected.connect(
		func(player: MPPlayer):
			print("Player disconnected: ",player.player_id)
	)
