extends Timer

func _on_timeout() -> void:
	Globals.save.save_to_file(FileAccess.open("user://save",FileAccess.WRITE))
	self.start()
