extends VBoxContainer

onready var description: Label = $Description
onready var check_box: CheckBox = $CheckBox

export(String) var label_text = "" setget set_label_text, get_label_text
export(String) var description_text = "" setget set_description_text, get_description_text
export(bool) var value = false setget set_value, get_value
signal data_changed(label, button_pressed)
var property setget set_property, get_property


func set_property(new_property):
	property = new_property
	label_text = property.name
	description_text = property.description


func get_property() -> float:
	return value


func set_value(new_value: bool):
	value = new_value
	if not check_box:
		yield(self, "ready")
	check_box.pressed = value


func get_value() -> bool:
	return value


func set_label_text(text: String):
	label_text = text
	if not check_box:
		yield(self, "ready")
	check_box.text = label_text.capitalize()


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


func _on_CheckBox_toggled(button_pressed):
	emit_signal("data_changed", label_text, button_pressed)
