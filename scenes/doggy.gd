extends CharacterBody2D

@onready var mpp: MPPlayer = get_parent()
@onready var bark_scene := preload("res://scenes/bark.tscn")

func _ready() -> void:
	mpp.player_ready.connect(_player_ready)
	$Camera2D.enabled = false
	
func _player_ready():
	$Camera2D.enabled = true
	$Camera2D.show()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("bark"):
		var b := bark_scene.instantiate()
		$Barks.add_child(b)
