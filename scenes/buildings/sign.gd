extends Node2D
class_name Sign

#@export_multiline var text: String
@export var dialog: DialogueData
@export var main_id: String = "main"

func _ready() -> void:
	$Interactable.interact.connect(_on_interact)

func _on_interact():
	Globals.game.ui.set_dialog_data(dialog)
	Globals.game.ui.start_dialog(main_id)
