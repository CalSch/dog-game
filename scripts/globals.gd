extends Node
#class_name _Globals

signal player_load

var game: Game
var player: Player :
	set(v):
		player = v
		player_load.emit()

var save: SaveFile

func _init() -> void:
	print("globals inited")
	if not FileAccess.file_exists("user://save"):
		save = SaveFile.new()
	else:
		save = SaveFile.load_from_file(FileAccess.open("user://save",FileAccess.READ))

@rpc("any_peer","call_remote","reliable")
func bark_bump(origin: Vector2):
	#print(mpp.player_id,position)
	#print(mpp.player_id,origin)
	print("bump: "+str(player.position.distance_to(origin)))
	if player.position.distance_to(origin) < 15.0:
		var v := (player.position-origin).normalized()*150.0
		v=v.rotated(deg_to_rad(randf_range(-30.0,30.0)))
		player.velocity += v

@rpc("any_peer")
func send_feedback(text:String):
	#if not 
	print("Got feedback: ")
	print(text)
	print("(end feedback)")
	if not FileAccess.file_exists("user://feedback.txt"):
		var file := FileAccess.open("user://feedback.txt",FileAccess.WRITE)
		file.close()
	var file := FileAccess.open("user://feedback.txt",FileAccess.READ_WRITE)
	var contents := file.get_as_text()
	contents += "\n\n"
	contents += Time.get_datetime_string_from_system()
	contents += "\n"
	contents += str(multiplayer.get_remote_sender_id())
	contents += "\n"
	contents += text
	file.store_string(contents)
	file.close()
	print("Written to feedback.txt")
	print("")
	
