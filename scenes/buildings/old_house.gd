extends Node2D

var dialog := preload("res://dialog/thingy.tres")

func _ready() -> void:
	$Interactable.interact.connect(interact)

func interact():
	Globals.game.ui.set_dialog_data(dialog)
	Globals.game.ui.start_dialog("door_interact")
