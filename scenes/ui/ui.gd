extends CanvasLayer
class_name GameUI

@export var dialog: DialogueBox
@export var feedback: Control

func _ready() -> void:
	dialog.visibility_changed.connect(_dialog_visibility_changed)
	dialog.variable_changed.connect(_var_change)
	feedback.get_node("SubmitButton").pressed.connect(_feedback_submit)
func trigger_feedback():
	$DialogContainer.show()
	feedback.show()
	print("feebdack")
	feedback.get_node("TextEdit").text = ""

func _feedback_submit():
	var text: String = feedback.get_node("TextEdit").text
	Globals.send_feedback.rpc_id(1,text)
	feedback.hide()
	$DialogContainer.hide()

func _var_change(variable_name: String, value):
	if variable_name.begins_with("!"):
		Globals.save.set_var(variable_name.substr(1),value)

func _dialog_visibility_changed():
	$DialogContainer.visible = dialog.visible

func set_dialog_data(data:DialogueData):
	dialog.data = data
func start_dialog(id:String):
	dialog.start(id)

func is_dialog_open() -> bool:
	return dialog.is_running() or feedback.visible
