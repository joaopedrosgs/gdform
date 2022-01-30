extends VBoxContainer

onready var label: Label = $Label
onready var description: Label = $Description
onready var float_line_edit = $FloatLineEdit

export(String) var label_text = "" setget set_label_text, get_label_text
export(String) var description_text = "" setget set_description_text, get_description_text
export(float) var value = 0.0 setget set_value, get_value
signal data_changed(label, new_number)


func set_value(new_value: float):
	value = new_value
	if not float_line_edit:
		yield(self, "ready")
	float_line_edit.text = String(value)


func get_value() -> float:
	return value


func set_label_text(text: String):
	label_text = text
	if not label:
		yield(self, "ready")
	label.text = label_text.capitalize()


func get_label_text() -> String:
	return label_text


func get_description_text() -> String:
	return description_text


func set_description_text(text: String):
	description_text = text
	if not description:
		yield(self, "ready")
	description.text = description_text


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FloatLineEdit_number_changed(new_number):
	emit_signal("data_changed", label_text, new_number)
