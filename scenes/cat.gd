extends Node2D
class_name Cat

#@export_multiline var text: String
@export var meow_radius: float = 100
var dialog: DialogueData = preload("res://dialog/cat.tres")

func _ready() -> void:
	$Interactable.interact.connect(_on_interact)
	Globals.player_load.connect(
		func():
			Globals.game.ui.dialog.dialogue_signal.connect(_dialog_signal)
			Globals.player.bark.connect(_on_bark)
	)

func _dialog_signal(value: String):
	if Globals.game.ui.dialog.data != dialog:
		return
	match value:
		"coal_quest":
			print("yummy coal")

func _on_bark():
	if Globals.player.position.distance_to(position)>meow_radius:
		return
	await get_tree().create_timer(randf_range(0.15,0.6)).timeout
	print("meow")

func _on_interact():
	Globals.game.ui.set_dialog_data(dialog)
	Globals.game.ui.start_dialog("main")
