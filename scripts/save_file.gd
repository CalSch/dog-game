extends Resource
class_name SaveFile

@export var vars: Dictionary = {
	"quests": {
		"coal": Quest.new()
	},
	"meows": 0
}

func set_var(path:String, value):
	var v = vars
	for part in path.split("/"):
		var new_v = v.get(part)
		#if new_v == null:
			#
	v = value
	print("set save var %s to %s" % [path,str(value)])

func to_json() -> String:
	return JSON.stringify({
		"vars": vars
	})
static func from_json(json: String) -> SaveFile:
	var data = JSON.parse_string(json)
	var save := SaveFile.new()
	if "vars" in data:
		save.vars = data["vars"]
	return save

func save_to_file(file:FileAccess):
	print("saving!")
	file.store_string(self.to_json())

static func load_from_file(file: FileAccess) -> SaveFile:
	print("loading!")
	return from_json(file.get_as_text())
