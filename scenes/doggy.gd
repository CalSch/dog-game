extends CharacterBody2D
class_name Player

@onready var mpp: MPPlayer = get_parent()
@onready var bark_scene := preload("res://scenes/bark.tscn")
@onready var dust_scene := preload("res://scenes/dust.tscn")

signal bark
signal interact

var already_interacted := false
func _on_interact_pressed(): # let others know they are open to interact
	already_interacted = false
	interact.emit()
func consume_interaction(): # stop the interaction from propogating
	already_interacted = true

func _ready() -> void:
	mpp.player_ready.connect(_player_ready)
	$Camera2D.enabled = false
	$Movement.landed.connect(_on_landed)

func _on_landed():
	pass
	#var d := dust_scene.instantiate()
	#Globals.game.spawn_particle(d,$MarkerBottom.global_position)

func _player_ready():
	if mpp.is_local:
		Globals.player = self
		$Camera2D.enabled = true
		$Camera2D.show()
		Globals.game.done_loading()
		$AnimatedSprite2D.material = $AnimatedSprite2D.material.duplicate()
		$AnimatedSprite2D.choose_random_palette()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(mpp.ma("bark")):
		var b := bark_scene.instantiate()
		print("bark!")
		$Barks.add_child(b,true)
		bark.emit()
		Globals.bark_bump.rpc(position)
	if event.is_action_pressed(mpp.ma("interact")):
		_on_interact_pressed()

func teleport(pos: Vector2):
	self.global_position = pos
	$Camera2D.reset_smoothing()


func save_to_file(file: FileAccess):
	#file.store_8()
	
	pass
