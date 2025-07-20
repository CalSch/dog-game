extends Area2D

@export var teleport_destination: Node2D

var is_player_in_area: bool = false
var bark_count: int = 0

func _ready() -> void:
	#while Globals.player == null:
		#pass
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	Globals.player_load.connect(_player_load)

func _player_load():
	Globals.player.bark.connect(_on_bark)

func _on_bark():
	if not is_player_in_area:
		return
	bark_count += 1
	if bark_count == 5:
		#teleport(Globals.player)
		Globals.player.teleport(teleport_destination.global_position + Vector2(0,-1))


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.mpp.is_local:
			is_player_in_area = true
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		if body.mpp.is_local:
			is_player_in_area = false
			bark_count = 0
