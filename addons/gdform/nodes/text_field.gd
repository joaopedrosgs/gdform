extends VBoxContainer

onready var label: Label = $Label
onready var description: Label = $Description
onready var line_edit: LineEdit = $LineEdit

export(String) var label_text = "" setget set_label_text, get_label_text
export(String) var description_text = "" setget set_description_text, get_description_text
export(String) var value = "" setget set_value, get_value
var pattern = ""
var min_lenght= 0
signal data_changed(label, text)

var property setget set_property, get_property


func set_property(new_property):
	property = new_property
	label_text = property.name.capitalize()
	description_text = property.description
	if property.has("minLength"):
		min_lenght = property.minLength
	if property.has("pattern"):
		pattern = property.pattern

func get_property() -> float:
	return value


func set_label_text(text: String):
	label_text = text
	if not label:
		yield(self, "ready")
	label.text = label_text.capitalize()


func get_label_text() -> String:
	return label_text


func set_value(text: String):
	value = text
	if not line_edit:
		yield(self, "ready")
	line_edit.text = value


func get_value() -> String:
	return value


func get_description_text() -> String:
	return description_text


func set_description_text(text: String):
	description_text = text
	if not description:
		yield(self, "ready")
	description.text = description_text


func _ready():
	if description_text == null || description_text == "":
		description.visible = false
	if property.has("maxLength"):
		line_edit.max_length = property.maxLength


func _on_LineEdit_text_changed(new_text:String):
	if new_text.length() < min_lenght:
		#TODO: Notify user
		return
	emit_signal("data_changed", label_text, new_text)
