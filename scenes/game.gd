extends Node2D
class_name Game

@onready var mpc: MultiPlayCore = get_parent()
@export var ui: GameUI


func _ready() -> void:
	Globals.game = self
	$UI.show()
	$UI/LoadingScreen.show()
	Globals.game.ui.dialog.dialogue_signal.connect(_dialog_signal)

func _dialog_signal(value:String):
	print("SIGNAL!! "+value)
	match value:
		"quit":
			get_tree().quit()
		"feedback":
			ui.trigger_feedback.call_deferred()

func done_loading():
	$UI/LoadingScreen.hide()
	#Globals.player.global_position = $SpawnPoint.global_position
	Globals.player.teleport($SpawnPoint.global_position)

func spawn_particle(node: Node2D, pos: Vector2):
	$Particles.add_child(node,true)
	node.global_position = pos
