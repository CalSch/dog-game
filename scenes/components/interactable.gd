extends Node
class_name Interactable

signal interact

@export var area: Area2D

func _ready() -> void:
	Globals.player_load.connect(_player_load)
func _player_load():
	Globals.player.interact.connect(_interact)
func _interact():
	if Globals.player.already_interacted:
		return
	if area.overlaps_body(Globals.player):
		Globals.player.consume_interaction()
		interact.emit()
